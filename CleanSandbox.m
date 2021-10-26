% this file is for testing code in a clean environment.
speed = 30;
shift = -1;
brick.SetColorMode(3,2);  
color = brick.ColorCode(3);
disp (color);
 pause(0.1)
    throttle = 0;
if color == 3
    brick.MoveMotor('A', 50);
   % brick.MoveMotor('B', shift * speed);
    
end
    
