function [gauss_plot, scat_plot, Dt, inms, new_inms, f, gof] = sep_peak(textfile,x)

    d = importdata(textfile, ' ');
    Dt = duration(d.textdata(:,2),'InputFormat','hh:mm:ss.SSSSSS','Format','hh:mm:ss.SSSSSS');
    inms = d.data(:,4);

    %%new array
    new_inms = zeros(length(inms),1);
    for i = [1:length(inms)]
        if inms(i) > 3
            new_inms(i,1) = inms(i);    
        else
            new_inms(i,1) = nan;

        end   
    end

    % estimating uncertianty in count
    new_inms;
    unc = sqrt(new_inms);
    
    %%% In this section of the code I will slice the data to fit the first peak in
    %%% Guassian fits will then plotted over the each peak.
    
    % plotting gaussian

    scat_plot = errorbar(hours(Dt(x)),new_inms(x), unc(x), "b*");
    hold on 
    [f,gof] = fit(hours(Dt(x)),inms(x),'gauss1','Exclude', inms(x) < 100,'Robust','LAR');
    gauss_plot = plot(f,hours(Dt(x)),new_inms(x))
    xlabel("Time (h)")
    ylabel("INMS counts")
    title(textfile)
    grid on
    hold off
    
    
end

