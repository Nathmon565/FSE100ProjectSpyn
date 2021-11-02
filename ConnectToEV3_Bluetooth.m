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

        disp("Trying to connect via bluetooth...");
        brick = Brick('ioType','instrbt','btDevice','EV2','btChannel',1);
        isBluetooth = true;
        disp("Connected via bluetooth!");
        brick.playTone(100, 500, 100);
        pause(1/10);
        brick.playTone(100, 600, 100);
        disp("Voltage: " + brick.GetBattVoltage());
    catch ME
        disp("Unable to connect via bluetooth!");
    end
end
clearvars ME