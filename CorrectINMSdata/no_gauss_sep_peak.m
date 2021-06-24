function [scat_plot] = no_gauss_sep_peak(textfile,x)

% function imports the INMS textfiles and extracts the time columns and
% the INMS counts columns. Plots individual Gaussian peaks of INMS counts 
% vs Time (h). 

% For this function to work it is necessary to
% save this function into the same directory/folder as the INMS
% textfiles.

    % importing columns from textfiles
    d = importdata(textfile, ' ');
    Dt = duration(d.textdata(:,2),'InputFormat','hh:mm:ss.SSSSSS','Format','hh:mm:ss.SSSSSS');
    inms = d.data(:,4);

    % new array
    % Removing 0 counts errors
    new_inms = zeros(length(inms),1);
    for i = [1:length(inms)]
        if inms(i) > 3
            new_inms(i,1) = inms(i);    
        else
            new_inms(i,1) = nan;

        end   
    end

    % estimating uncertianty in count
    % new_inms;
    unc = sqrt(new_inms);
    
    % In this section of the code I will slice the data to fit the first peak in
    % Guassian fits will then plotted over the each peak.
    
    % plotting gaussian
    
    scat_plot = errorbar(hours(Dt(x)),new_inms(x), unc(x), "b*");
    xlabel("Time (h)")
    ylabel("INMS counts")
    title(textfile)
    grid on
    
end

