function [contour_vector] = densityANDwind(textfile, f107A, f107D, ap)

% HWM vector field overlaid on top of a NRLMSISE O density contour map.
% This will display arrows showing wind vector fields calculated by the HWM
% model and it will be plotted on top of the NRLMSISE oxygen density
% contour maps. The inputs for the function are the parameters from the
% textfiles, f10.7 values and Ap index.

%%% NOTE:
%%% This function will work only if "densityANDwind.m" file is in the same
%%% directory as the INMS textfiles. The function also depends on the
%%% HWM_vectorfield function. Please make sure "HWM_vectorfield.m" is also
%%% in the same directory as the INMS textfiles.


    % changing directory to the directory where INMS textfiles are stored
    %cd ("C:\Users\Rifat\OneDrive - University College London\Rifat's PC\UCL\Y4\Project\MATLAB\CorrectINMSdata"); %path
    disp("Plotting HWM wind vector and NRLMSISE density contour map for each day")
    
    % exporting data from textfiles
    date = importdata(textfile,' ');
    h = mean(date.data(:,3)*1000);
    days = day(datetime(date.textdata(1,1)), 'dayofyear');
    time = seconds(duration(date.textdata(600,2),'InputFormat','hh:mm:ss.SSSSSS','Format','hh:mm:ss.SSSSSS'));
    
    % filling empty matrix with O density values
    lat5 = [1:180];
    lon5 = [1:360];
    odens = nan(180,360); 
    for i = lat5
        for j = lon5
            
           [T, rho] =  atmosnrlmsise00(h,i-91,j-181,2018,days,time,f107A,f107D,ap); % Computing NRLMSISE model
           Ox = rho(:,2); % choosing O+ density from the list of outputs of the model
           odens(i,j) = Ox; %O+ density

        end
    end
    
    % plotting routine 
    load coastlines.mat;
    [X,Y]= meshgrid(-179:180, -89:90);
    contourf(X,Y,odens,100,"LineColor","none")
    colorbar
    hold on;
    plot(coastlon, coastlat,"b")
    box on
    xlim([-180 180])
    ylim([-90 90])
    xlabel("longitude")
    ylabel("latitude")
    hold on
    [contour_vector] = HWM_vectorfield(textfile,3) 
    hold off

end

