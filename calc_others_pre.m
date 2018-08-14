function midpoint = calc_others (img_edge, top_point)
%imshow(img_edge);hold on;

%plot(top_point(1), top_point(2), 'x','LineWidth',2,'Color','yellow');
cursor(2) = top_point(1);cursor(1) = top_point(2);

while sum(sum(img_edge(cursor(1)-1:cursor(1)+5, cursor(2)+1:cursor(2)+8))) > 1
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
while img_edge(cursor(2) - 1, cursor(1))
    cursor(2) = cursor(2) - 1;
end

midpoint = [top_point(1) cursor(1)];
end