function [density_vs_time, Ox] = nrlmsise_alongpath_time(textfile, f107A, f107D, ap)

    % Plotting nrlmsise00 oxygen densities along Cubesat trajecotry 
    % for each day against time. Takes all parameters from textfiles as well  
    % as F10.7 monthly average, F10.7 daily average and Ap index
    
    % For this function to work it is necessary to
    % save this function into the same directory/folder as the INMS
    % textfiles.
    
    %%% NRLMSISE Oxygen densities along the trajectory of the Cubesat

    cd ("C:\Users\rifat\OneDrive - University College London\Rifat's PC\UCL\Y4\Project\MATLAB\Rifat's project\CorrectINMSdata"); %path
    disp("Plotting nrlmsise densities vs time for a chosen day along CubeSat directory")

    date = importdata(textfile,' ');
    lon = date.data(:,1);
    lat = date.data(:,2);
    h = date.data(:,3)*1000;
    days = day(datetime(date.textdata(:,1)), 'dayofyear');
    time = seconds(duration(date.textdata(:,2),'InputFormat','hh:mm:ss.SSSSSS','Format','hh:mm:ss.SSSSSS'));
    api = repmat(ap,length(h),1);
    [T, rho] = atmosnrlmsise00(h, lat, lon, 2018, days, time, f107A, f107D, api); % computing NRLMSISE model
    Ox = rho(:,2); % extracting oxygen density

    % plotting routine
    density_vs_time = scatter(time,Ox,"ro")
    ylabel("NRLMSISE O density (m^-3)");
    xlabel("time (s)");
    grid on;
    title(textfile);
    legend(strcat("Ap index:",num2str(ap)," F107D:",num2str(f107D)));
end

