global key;
InitKeyboard();
speed = 30;
while 1
    pause(0.1)
    leftWheel = 0;
    rightWheel = 0;
    switch key
        case 'uparrow'
            leftWheel = leftWheel + 1;
            rightWheel = rightWheel + 1;
        case 'downarrow'
            leftWheel = leftWheel - 1;
            rightWheel = rightWheel - 1;
        case 'leftarrow'
            leftWheel = leftWheel - 0.5;
            rightWheel = rightWheel + 0.5;
        case 'rightarrow'
            leftWheel = leftWheel + 0.5;
            rightWheel = rightWheel - 0.5;
        case 'q'
            break;
    end
    brick.MoveMotor('A', rightWheel * speed);
    brick.MoveMotor('B', leftWheel * speed);
    disp(leftWheel + ", " + rightWheel);
end
CloseKeyboard();
clearvars key leftWheel rightWheel speed