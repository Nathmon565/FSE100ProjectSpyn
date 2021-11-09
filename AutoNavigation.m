 DriveForward(brick);

% done
disp("done");
brick.StopAllMotors();
brick.beep();

function Shift(brick, drive)
    if(drive)
        brick.MoveMotor('D', -25);
    else
        brick.MoveMotor('D', 25);
    end
    pause(0.5);
end

% Shift to turn, drive 90 degrees left, shift to drive
function TurnLeft(brick)
    Shift(brick, false);
    brick.MoveMotorAngleRel('A', 70, -360 * 3, 'Brake');
    while(brick.MotorBusy('A')); end
    Shift(brick, true);
end

% Shift to turn, drive 90 degrees left, shift to drive
function TurnRight(brick)
    Shift(brick, false);
    brick.MoveMotorAngleRel('A', 70, 360 * 3, 'Brake');
    while(brick.MotorBusy('A')); end
    Shift(brick, true);
end

% Drive forward 1 square; check for button press, red strip, wall
function DriveForward(brick)
    % whether a stop sign has been witnessed this drive
    seenStopSign = false;
    Shift(brick, true);
    % drive forward 1 squrae
    brick.MoveMotorAngleRel('A', 70, 360 * 21, 'Brake');
    % while busy
    while(brick.MotorBusy('A'))
        % if pressed
        if(brick.TouchPressed(4))
            % stop driving
            brick.StopMotor('A', 'Brake');
            BackUpTurnLeft(brick);
            break;
        end
        
        % if red tape
        color = brick.ColorCode(2);
        if(color == 5 && ~seenStopSign)
            seenStopSign = true;
            % stop driving
            brick.StopMotor('A', 'Brake');
            brick.beep();
            % wait at line
            pause(3);
            % drive one half more forward
            brick.MoveMotorAngleRel('A', 70, 360 * 10.5, 'Brake');
        end
        clearvars color
    end
    
    % check for no wall
    if(brick.UltrasonicDist(1) > 25)
        TurnRight(brick);
    end
    
    DriveForward(brick);
end

function BackUpTurnLeft(brick)
    % drive back
    brick.MoveMotorAngleRel('A', 70, -360 * 5, 'Brake');
    while(brick.MotorBusy('A')); end
    Shift(brick, false);
    % turn left
    TurnLeft(brick);
end