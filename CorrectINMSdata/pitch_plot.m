function [pitch_line,pitch_data] = pitch_plot(n,m,inms,Dt)

%   This function extracts the pitch plot from the data. It first scans the
%   number of counts in Sachin's excel sheet and also scans the number of
%   counts in the textfiles. If the current scanned count in the two files
%   is the same, then the corresponding pitch value is extracted into the
%   the "pitch1" array. This array is finally plotted with the Gaussian
%   distributions of INMS counts.

% For this function to work it is necessary to
% save this function into the same directory/folder as the INMS
% textfiles and the "Data_Sachin1.csv" excel sheet.



    % importing pitch data
    sach = readtable("Data_Sachin1.csv.xlsx","Sheet","Data_Sachin");
    rot = sach.Var3(n:m);
    count = sach.Var23(n:m);
   
    day_size = m - n;
    pitch1 = nan(day_size,1);
    time1 = duration(nan(835,3));

    for i = 1:length(rot)
        if(count(i) > 20)  
            
            for j = 1:835
                if (inms(j) == count(i))
                    
                    pitch1(i) = rot(i);
                    time1(j) = Dt(j);
                    break   

                else 
                    continue
                end           
            end 
        else
            continue
        end
    end

    pitch_data = rmmissing(pitch1);
    pitch_time = rmmissing(time1);
    
    % plotting the pitch data extracted
    pitch_line = plot(hours(pitch_time), pitch_data(1:length(pitch_time)), "co-");
    grid on;
    
end

