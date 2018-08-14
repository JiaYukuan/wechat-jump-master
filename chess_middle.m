function [midpoint] = chess_middle(img)
img_red = img(:,:,1);
img_green = img(:,:,2);
img_blue = img(:,:,3);

%filter for chess color
is_chess = (abs(img_red - 54) + abs (img_green - 60) + abs(img_blue - 102) < 10);

%looking for the leftmost verified point of chess (detail in repo)
chess_column = sum(is_chess);
found = 0;
for left_bound = 150:1000
    if chess_column(left_bound) > 0
        for k = 1620:-1:900
            if  is_chess(k, left_bound) && sum(is_chess(k, left_bound :1: left_bound+60)) > 55 && is_chess(k+15, left_bound+38) && sum(is_chess(k-80:1:k, left_bound+38)) > 40
                left_point_x = left_bound;
                left_point_y = k;
                found = 1;
                break;
            end
        end
        if(found == 1)
            break;
        end
    end
end
%approximately get the bottom point
midpoint = [left_point_x + 37 left_point_y+17];

%modify the height
if is_chess(midpoint(2), midpoint(1) == 0)
    midpoint(2) = midpoint(2) - 1;
end
while is_chess(midpoint(2)+1, midpoint(1))
    midpoint(2) = midpoint(2) + 1;
end

%modify the width
left = midpoint(1); right = midpoint(1);
while is_chess(midpoint(2), left - 1)
    left = left - 1;
end
while is_chess(midpoint(2), right + 1)
    right = right + 1;
end
midpoint(1) = floor((left+right)/2);

end