% this file is for testing code in a clean environment.

InitKeyboard();
while 1
    pause(0.1)
    switch key
        case 'uparrow'
            disp("up")
        case 'downarrow'
            disp("down")
        case 'leftarrow'
            disp("left")
        case 'rightarrow'
            disp("right")
        case 0
            disp("none")
        case 'q'
            break;
    end
end
CloseKeyboard();