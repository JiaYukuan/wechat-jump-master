    num = 0;
    while true
        im = read_image(num);
        figure; imshow(im); hold on;
        chess = chess_middle(im);
        board = board_middle(im, chess(1));
        plot(chess(1), chess(2), 'x','LineWidth',2,'Color','yellow');
        plot(board(1), board(2), 'x','LineWidth',2,'Color','red');
        dis = distance(chess, board);
        dis = int16(round(dis))
        press_screen(dis);
        pause(1);
        num = num + 1;
    end
