file = matlab.desktop.editor.getActiveFilename;
[filePath,fileName,fileExtension] = fileparts(file);
ev3 = filePath + "\EV3";
clearvars file filePath fileName fileExtension

try
    brick.playTone(100, 500, 100);
    disp("Already connected!");
catch ME
    clearvars ME
    try
        disp("Connecting to simulation...");
        javaclasspath(ev3);
        disp("Loaded java class path...");
        
        disp("Connecting via 127.0.0.1...");
        brick = Brick('ioType','wifi','wfAddr','127.0.0.1','wfPort',5555,'wfSN','0016533dbaf5');
        brick.playTone(100, 600, 100);
        pause(1/10);
        brick.playTone(100, 500, 100);
        disp("Connected!");
        disp("Voltage: " + brick.GetBattVoltage());
    catch ME
        disp("No simulation available! Ensure it's running.");
        clearvars ME
    end
end