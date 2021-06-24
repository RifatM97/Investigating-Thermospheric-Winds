function [wind_vs_time] = hwm_alongpath_time(textfile,ap)

    % function plots the winds computed by the HWM model along the 
    % CubeSat trajectory for each day against time. Takes in all the
    % parameters from the textfiles and an Ap value for that day. Outputs a
    % graph of wind magnitudes against time
    
    % Plotting nrlmsise00 oxygen densities along Cubesat trajecotry 
    % for each day against time. Takes all parameters from textfiles as well  
    % as F10.7 monthly average, F10.7 daily average and Ap index
    
    %%% HWM winds speeds along the trajectory of the Cubesat

    %cd ("C:\Users\Rifat\OneDrive - University College London\Rifat's PC\UCL\Y4\Project\MATLAB\CorrectINMSdata"); %path
    disp("Plotting hwm winds vs time for a chosen day along CubeSat directory")

    % exctracting data from textfiles
    date = importdata(textfile,' ');
    lon = date.data(:,1);
    lat = date.data(:,2);
    h = date.data(:,3)*1000;
    days = day(datetime(date.textdata(:,1)), 'dayofyear');
    time = seconds(duration(date.textdata(:,2),'InputFormat','hh:mm:ss.SSSSSS','Format','hh:mm:ss.SSSSSS'));
    api = repmat(ap,length(h),1);
    
    % running HWM model
    wind_model = atmoshwm(lat,lon,h,"day",days, "seconds", time,'apindex', api,'model','total','version','14');
    %mag_wind = sqrt((wind_model(:,1)).^2 + (wind_model(:,2)).^2);
    
    % plotting routine
    wind_vs_time = scatter(time,wind_model(:,2),"ro")
    %wind_vs_time = quiver(wind_model(1:835,2),wind_model(1:835,1),)
    ylabel("HWM winds speeds (m/s)");
    xlabel("time (s)");
    grid on;
    title(textfile)
    legend(strcat("Ap index:",num2str(ap)))
end

