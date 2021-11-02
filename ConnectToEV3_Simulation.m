file = matlab.desktop.editor.getActiveFilename;
[filePath,fileName,fileExtension] = fileparts(file);
ev3 = filePath + "\EV3";
clearvars file filePath fileName fileExtension
try
    brick.playTone(100, 500, 100);
    disp("Already connected!");
catch ME
    try
        disp("No connection, attempting to create a new connection...");
        clearvars ME brick
        disp("Creating java class path...");
        javaclasspath(ev3);
        disp("Loaded java class path...");

        disp("Trying to connect via simulation...");
        brick = Brick('ioType','wifi','wfAddr','127.0.0.1','wfPort',5555,'wfSN','0016533dbaf5');
        isBluetooth = false;
        disp("Connected via simulation!");
        brick.playTone(100, 600, 100);
        pause(1/10);
        brick.playTone(100, 500, 100);
    catch ME
        disp("Unable to connect via simulation!");
    end
end
clearvars ME