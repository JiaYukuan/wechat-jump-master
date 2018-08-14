function midpoint = board_middle(img, chess_x)
img_red = img(:,:,1);
img_green = img(:,:,2);
img_blue = img(:,:,3);
img_hsv = rgb2hsv(img);
img_bw = img_hsv(:,:,2);
img_edge = edge(img_bw, 'canny');
%figure;imshow(img_edge); hold on;

if(chess_x <= 540)
    img_edge = img_edge .* [zeros(1,chess_x+33) ones(1, 1080 - (chess_x+33))];
else
    img_edge = img_edge .* [ones(1,chess_x-33) zeros(1, 1080 - (chess_x-33))];
end

[H, T, R] = hough(img_edge);
P = houghpeaks(H, 100, 'threshold', 0);
lines = houghlines(img_edge, T, R, P, 'FillGap', 11, 'MinLength', 80);
tallest_left_line_height = 1920; tallest_left_line = 1;
tallest_right_line_height = 1920; tallest_right_line = 1;
for k = 1:length(lines)
    if lines(k).theta >= 58 && lines(k).theta <= 62
        if max(lines(k).point1(2), lines(k).point2(2)) < tallest_left_line_height
            tallest_left_line = k;
            tallest_left_line_height = max(lines(k).point1(2), lines(k).point2(2));
        end
    end
end
for k = 1:length(lines)
    if lines(k).theta >= -62 && lines(k).theta <= -58
        if max(lines(k).point1(2), lines(k).point2(2)) < tallest_right_line_height
            tallest_right_line = k;
            tallest_right_line_height = max(lines(k).point1(2), lines(k).point2(2));
        end
    end
end
xy = [lines(tallest_left_line).point1; lines(tallest_left_line).point2];
        %plot(xy(:,1), xy(:,2), 'LineWidth', 1, 'Color', 'red');
xy = [lines(tallest_right_line).point1; lines(tallest_right_line).point2];
        %plot(xy(:,1), xy(:,2), 'LineWidth', 1, 'Color', 'red');

is_music = (abs(int16(img_red) - 177) + abs (int16(img_green) - 181) + abs(int16(img_blue) - 209) < 5);

sum_raw = sum(img_edge, 2);
for top_corner = 400:1800
    found = 0;
    if(sum_raw(top_corner) > 0)
        for k = 101:1000
            if img_edge(top_corner, k) == 1 && sum(img_edge(top_corner, k-50:k)) < 45 && sum(img_edge(top_corner, k:k+50)) < 45 && sum(sum(is_music(top_corner-3:top_corner+3, k-3:k+3))) == 0
                top_point(1) = k + floor(sum(img_edge(top_corner, k:k+40)/2));
                top_point(2) = top_corner;
                found = 1;
                break;
            end
        end
        if(found == 1)
            break;
        end
    end
end
%plot(top_point(1), top_point(2), 'x','LineWidth',2,'Color','yellow');

if distance(lines(tallest_left_line).point2, top_point) < 10
    left_verified = 1;
else
    left_verified = 0;
end
if distance(lines(tallest_right_line).point1, top_point) < 10
    right_verified = 1;
else
    right_verified = 0;
end
length_left = distance(lines(tallest_left_line).point1, lines(tallest_left_line).point2);
length_right = distance(lines(tallest_right_line).point1, lines(tallest_right_line).point2);
if left_verified && right_verified 
    if  length_left * 1.4 < length_right 
        left_verified = 0;
    elseif length_left > length_right * 1.4
        right_verified = 0;
    end
end
if left_verified 
    if right_verified 
        midpoint(1) = ceil((lines(tallest_left_line).point1(1) + lines(tallest_right_line).point2(1))/2);
        midpoint(2) = ceil((lines(tallest_left_line).point1(2) + lines(tallest_right_line).point2(2))/2);
    else
        midpoint(1) = top_point(1);
        midpoint(2) = lines(tallest_left_line).point1(2);
    end
else
    if right_verified
        midpoint(1) = top_point(1);
        midpoint(2) = lines(tallest_right_line).point2(2);
    else
        midpoint = calc_others(img, top_point);
    end
end
%plot(midpoint(1), midpoint(2), 'x','LineWidth',2,'Color','red');
end