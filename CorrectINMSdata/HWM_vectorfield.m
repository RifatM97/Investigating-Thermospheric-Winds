function [vector_field] = HWM_vectorfield(textfile,ap)
% ----------------------------------------------------------------------- %
% Computed the HWM vector fields using all the parameters from the
% textfiles and given an Ap index value for that day. The trajectory o
% of Phoenix is also traced. 

% For this function to work it is necessary to
% save this function into the same directory/folder as the INMS
% textfiles.

    % wind vector fields
    % cd ("C:\Users\user\OneDrive - University College London\Rifat's PC\UCL\Y4\Project\MATLAB\CorrectINMSdata"); %path
    disp("Plotting HWM wind vector field for each day")
    
    % importing columns from textfile
    date = importdata(textfile,' ');
    lon = date.data(:,1);
    lat = date.data(:,2);
    h = mean(date.data(:,3)*1000);
    days = day(datetime(date.textdata(1,1)), 'dayofyear');
    time = seconds(duration(date.textdata(600,2),'InputFormat','hh:mm:ss.SSSSSS','Format','hh:mm:ss.SSSSSS'));
    api = ap;
    
    
    % filling up matrices with wind speeds from HWM model
    lat5 = [1:4:180];
    lon5 = [1:4:360];
    w_mat5 = nan(180,360);
    w_mat6 = nan(180,360);
    for i = lat5
        for j = lon5
            
           wind_vel5 = atmoshwm(i-91,j-181,h,'day',days,'seconds',time,'apindex',api,'model','total','version','14'); % computing HWM model
           w_mat5(i,j) = wind_vel5(1); %meridional wind matrix
           w_mat6(i,j) = wind_vel5(2); %zonal wind matrix
           
        end
    end
    
  
    % plotting routine
    % Matrices used to create quiver plots
    
    %load coastlines.mat;
    [X,Y]= meshgrid(-179:180, -89:90);
    vector_field = quiver(X,Y,w_mat6,w_mat5,10,"g","LineWidth",0.5)
    hold on;
    plot(coastlon, coastlat,"r","LineWidth",2)
    box on
    hold on
    plot(lon, lat, "m*-","LineWidth",3)
    xlim([-180 180])
    ylim([-90 90])
    xlabel("longitude")
    ylabel("latitude")
    hold off
    title(textfile)
    legend(strcat("Ap index:",num2str(ap)))

end

