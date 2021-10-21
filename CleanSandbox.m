% this file is for testing code in a clean environment.
global key;
InitKeyboard();
while 1
    pause(0.1)
    switch key
        case 'uparrow'
            brick.MoveMotor('AB',30)
            disp("up")
        case 'downarrow'
             brick.MoveMotor('AB',-30)
            disp("down")
        case 'leftarrow'
             brick.MoveMotor('A',30)
            disp("left")
        case 'rightarrow'
            disp("right")
             brick.MoveMotor('B',30)
        case 0
             brick.StopMotor('AB')
            disp("none")
        case 'q'
            break;
    end
end
CloseKeyboard();