function [gauss_plot, inms_plot, Dt, inms, new_inms, f] = inms_import(textfile)

    % function imports the INMS textfiles and extracts the time columns and
    % the INMS counts columns. Plots Gaussian distributions on scatter
    % plots of INMS counts vs Time (h).
    
    % For this function to work it is necessary to
    % save this function into the same directory/folder as the INMS
    % textfiles.
      
    
    % importing INMS and time columns from textfiles
    d = importdata(textfile, ' ');
    Dt = duration(d.textdata(:,2),'InputFormat','hh:mm:ss.SSSSSS','Format','hh:mm:ss.SSSSSS');
    inms = d.data(:,4);

    % new array to remove zero count clutters
    new_inms = zeros(length(inms),1);
    for i = [1:length(inms)]
        if inms(i) > 3
            new_inms(i,1) = inms(i);

        else
            new_inms(i,1) = nan;
        end
    end
    
    % creating scatter plot of INMS vs Time
    figure;
    inms_plot = scatter(Dt,new_inms,'r*')
    xlabel("Time (h)")
    ylabel("INMS Counts")
    title(textfile)

    % plotting Gaussian fits to scatter plot
    figure;
    f = fit(hours(Dt),inms,'gauss8','Exclude', inms < 50,'Robust','LAR')
    gauss_plot = plot(f,hours(Dt),new_inms)
    xlabel("Time (h)")
    ylabel("INMS Counts")
    title(textfile)
    
end

