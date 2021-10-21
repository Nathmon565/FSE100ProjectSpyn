% Motor A: Drive
% Motor B: Clutch, -1 is forwards
% Motor C: Claw
% Input 1: Touch Sensor 1
% Input 2: Touch Sensor 2
% Input 3: Color Sensor
% Input 4: Ultrasonic Sensor
% Input X: Gyro Sensor
global key;
InitKeyboard();
speed = 30;
shift = -1;
while 1
    pause(0.1)
    throttle = 0;
    switch key
        case 'uparrow'
            throttle = 1;
        case 'downarrow'
            throttle = -1;
        case 'leftarrow'
            shift = -1;
        case 'rightarrow'
            shift = 1;
        case 'q'
            break;
    end
    brick.MoveMotor('A', throttle * speed);
    brick.MoveMotor('B', shift * speed);
end
CloseKeyboard();
clearvars key leftWheel rightWheel speed