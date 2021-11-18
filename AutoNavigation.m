Start(brick, false);

function Start(brick, hasChair)
    DriveForward(brick, hasChair);
    disp("All done!");
    brick.StopAllMotors();
    brick.beep();
end
    
function Shift(brick, drive)
    if(drive)
        disp("Shifting to drive");
        brick.MoveMotor('D', -25);
    else
        disp("Shifting to turn");
        brick.MoveMotor('D', 25);
    end
    pause(0.5);
end

% Shift to turn, drive 90 degrees left, shift to drive
function TurnLeft(brick)
    disp("Turning left...");
    Shift(brick, false);
    brick.MoveMotorAngleRel('A', 70, -360 * 2.9, 'Brake');
    while(brick.MotorBusy('A')); end
    disp("Next!");
    Shift(brick, true);
end

% Shift to turn, drive 90 degrees left, shift to drive
function TurnRight(brick)
    disp("Turning right...");
    Shift(brick, false);
    brick.MoveMotorAngleRel('A', 70, 360 * 3.15, 'Brake');
    while(brick.MotorBusy('A')); end
    disp("Next!");
    Shift(brick, true);
end

function TurnAround(brick)
    disp("Turning around...");
    Shift(brick, false);
    brick.MoveMotorAngleRel('A', 70, 360 * 6.3, 'Brake');
    while(brick.MotorBusy('A')); end
    disp("Next!");
    Shift(brick, true);
   
end

% Drive forward 1 square; check for button press, red strip, wall
function DriveForward(brick, hasChair)
    disp("Driving forward...");
    yellowSafety = 0;
    yellowThresh = 5;
    % whether a stop sign has been witnessed this drive
    seenStopSign = false;
    Shift(brick, true);
    % drive forward 1 squrae
    brick.MoveMotorAngleRel('A', 70, 360 * 21, 'Brake');
    % while busy
    while(brick.MotorBusy('A'))
        % if pressed
        if(brick.TouchPressed(4) || brick.TouchPressed(3))
            disp("Hit wall!");
            % stop driving
            brick.StopMotor('A', 'Brake');
            BackUpTurnLeft(brick);
            break;
        end
        
        % if red tape
        color = brick.ColorCode(2);
        if(color == 5 && ~seenStopSign)
            disp("Red! Stop!");
            seenStopSign = true;
            % stop driving
            brick.StopMotor('A', 'Brake');
            % wait at line
            pause(3);
            % drive one half more forward
            disp("Driving forward 1/2...");
            brick.MoveMotorAngleRel('A', 70, 360 * 10.5, 'Brake');
        elseif(color == 3) % green dropoff
            brick.StopMotor('A', 'Brake');
            disp("Green!");
            DropOff(brick);
            return;
        elseif(color == 4 && ~hasChair) % yellow pickup
            disp("Yellow!");
            if(yellowSafety > yellowThresh)
                brick.StopAllMotors();
                ManualControl(brick);
                hasChair = true;
            else
                yellowSafety = yellowSafety + 1;
            end
        else
            yellowSafety = 0;
        end
        
        clearvars color
    end
    
    % check for no wall
    if(brick.UltrasonicDist(1) > 30)
        disp("No wall!");
        TurnRight(brick);
    end
    disp("Next!");
    DriveForward(brick, hasChair);
end

function BackUpTurnLeft(brick)
    disp("Backing up!");
    % drive back
    brick.MoveMotorAngleRel('A', 70, -360 * 7, 'Brake');
    while(brick.MotorBusy('A')); BackUpBeeping(brick); end
    Shift(brick, false);
    disp("Next!");
    % turn left
    TurnLeft(brick);
end

function BackUpBeeping(brick)
    brick.beep();
    pause(0.25);
end

%brick.MoveMotorAngleAbs('C', 100, 0); sync - touching
%brick.MoveMotorAngleAbs('C', 100, -1000); open
%brick.MoveMotorAngleAbs('C', 100, 250); grabbing

function DropOff(brick)
    TurnAround(brick);
    brick.MoveMotorAngleAbs('C', 100, -1000);
    while(brick.MotorBusy('C')); end
end

function ManualControl(brick)
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
end