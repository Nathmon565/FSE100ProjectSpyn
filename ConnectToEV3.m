try
    brick.playTone(100, 500, 100);
catch ME
    try
        javaclasspath("C:\Users\natha\Tools\MATLAB\toolbox\EV3");
        brick = Brick('ioType','wifi','wfAddr','127.0.0.1','wfPort',5555,'wfSN','0016533dbaf5');
        brick.playTone(100, 600, 100);
        pause(1/10);
        brick.playTone(100, 500, 100);
        disp("Voltage: " + brick.GetBattVoltage());
    catch ME
        disp("No simulation available. Ensure it's running.");
    end
end