function midpoint = calc_others (img, top_point)
img_hsv = rgb2hsv(img);
img_bw = img_hsv(:,:,2);
img_edge = edge(img_bw, 'canny');
%imshow(img_edge);hold on;

%plot(top_point(1), top_point(2), 'x','LineWidth',2,'Color','yellow');
cursor(2) = top_point(1);cursor(1) = top_point(2);

while sum(sum(img_edge(cursor(1)-1:cursor(1)+5, cursor(2)+1:cursor(2)+8))) > 1 && cursor(1) < 1500 && cursor(2) < 1060
    found = 0;
    for right = 8:-1:1
        for down = 5:-1:-1
            if img_edge(cursor(1)+down, cursor(2)+right) && right+down > 0
                cursor = cursor + [down right];
                found = 1;
                break;
            end
        end
        if found
            break;
        end
    end
    %plot(cursor(2), cursor(1), 'x','LineWidth',1,'Color','red');
end

while img_edge(cursor(1) - 1, cursor(2))
    cursor(1) = cursor(1) - 1;
end

if abs(sum(int16(img(cursor(1), cursor(2), :)) - int16(img(cursor(1), cursor(2) - 1, :)))) > 5
    if abs(sum(int16(img(cursor(1) + 2, cursor(2), :)) - int16(img(cursor(1), cursor(2) - 1, :)))) < 5
        cursor(1) = cursor(1) + 2;
    elseif abs(sum(int16(img(cursor(1) + 1, cursor(2), :)) - int16(img(cursor(1), cursor(2) - 1, :)))) < 5
        cursor(1) = cursor(1) + 1;
    elseif abs(sum(int16(img(cursor(1) - 1, cursor(2), :)) - int16(img(cursor(1), cursor(2) - 1, :)))) < 5
        cursor(1) = cursor(1) - 1;
     elseif abs(sum(int16(img(cursor(1) - 2, cursor(2), :)) - int16(img(cursor(1), cursor(2) - 1, :)))) < 5
        cursor(1) = cursor(1) - 2;
    end
end
same_layer = img(cursor(1):cursor(1) + 50, cursor(2), 1:3);
same_layer_red = same_layer(:,:,1);
same_layer_green = same_layer(:,:,2);
same_layer_blue = same_layer(:,:,3);
same_layer = (abs(int16(same_layer_red) - int16(same_layer_red(1,1))) + abs (int16(same_layer_green) - int16(same_layer_green(1,1))) + abs(int16(same_layer_blue) - int16(same_layer_blue(1,1))) < 5);
layerlength = 1;
while(same_layer(layerlength, 1)  && layerlength < 50)
    layerlength = layerlength + 1;
end
if sum(sum(same_layer)) < 15
    midpoint = [top_point(1) cursor(1)+floor(layerlength/2)];
else
    midpoint = [top_point(1) cursor(1)];
end