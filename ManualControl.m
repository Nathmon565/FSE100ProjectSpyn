% Simulation Robot Setup
% Motor A: Drive
% Motor B: Clutch, -1 is forwards
% Motor C: Claw
% Motor D: 
% Input 1: Touch Sensor 1
% Input 2: Touch Sensor 2
% Input 3: Color Sensor
% Input 4: Ultrasonic Sensor
% Input X: Gyro Sensor

% Physical Robot Setup
% Motor A: Drive
% Motor B: 
% Motor C: Claw
% Motor D: Clutch, -1 is forwards
% Input 1: Ultrasonic
% Input 2: Color
% Input 3: Gyro
% Input 4: Pressure
global key;
InitKeyboard();
driveSpeed = 50;
shiftSpeed = 25;
clawSpeed = 50;
shift = -1;
shiftDelay = 1;
while 1
    pause(0.1)
    throttle = 0;
    claw = 0;
    needClutch = 0;
    switch key
        case 'uparrow'
            shift = -1;
            throttle = 1;
            needClutch = 1;
        case 'downarrow'
            shift = -1;
            throttle = -1;
            needClutch = 1;
        case 'leftarrow'
            shift = 1;
            needClutch = 1;
            throttle = -1;
        case 'rightarrow'
            shift = 1;
            needClutch = 1;
            throttle = 1;
        case 'pagedown'
            claw = 1;
        case 'pageup'
            claw = -1;
        case 'q'
            break;
    end
    color = brick.ColorCode(2);
    if(color == 5)
        %brick.beep();
    end
    if brick.TouchPressed(4)
        %brick.beep();
    end
    if brick.UltrasonicDist(1) > 25
        %brick.beep();
    end
    brick.MoveMotor('A', throttle * driveSpeed);
    brick.MoveMotor('D', shift * shiftSpeed * needClutch);
    brick.MoveMotor('C', claw * clawSpeed);
end
brick.StopAllMotors();
CloseKeyboard();
clearvars key shift driveSpeed shiftSpeed throttle claw clawSpeed needClutch shiftDelay