
    im = read_image();
    figure; imshow(im); hold on;
    chess = chess_middle(im);
    board = board_middle(im, chess(1));
    plot(chess(1), chess(2), 'x','LineWidth',2,'Color','yellow');
    plot(board(1), board(2), 'x','LineWidth',2,'Color','red');
    dis = distance(chess, board);
    dis = int16(round(dis))
    pause(1);
