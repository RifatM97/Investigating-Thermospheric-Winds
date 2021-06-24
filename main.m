%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% main.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%------------------------------------------------------------------------%

%%% Notes:

% This script merges all the other MATLAB files and runs them to produce
% plots and figures, given a specified date in which the INMS collected
% data. This main.m file is saved in the Rifat's project directory. 
% To execute this, please make sure that your current/starting directory 
% is \..\Rifat's project, where the main.m is saved. Press the run botton
% under the editor tab and a request in the command window should pop up.
% Choose the date that you want to analyse in the correct format and wait
% till the execution ends completely. This should take no more than a 120
% seconds. Seven different figures should open up in seperate windows. 
% The script automatically imports and visualises the data using the
% pre-written functions. Please refeer to the User Guide for more
% information.
 

% Clear command line
clc;
% Change directory to folder in which txt files are stored
cd ("C:\Users\rifat\OneDrive - University College London\Rifat's PC\Internship 2021\Rifat's project\CorrectINMSdata"); 
%% Choosing a date from the command line

prompt = "Please Choose date with format 'yyyy-m-d.txt':";
textfile = input(prompt)

%% importing INMS data and plotting scatter plot and Gaussian fits
% This uses the function in inms_import.m file

[gauss_plot] = inms_import(textfile)
title("INMS Gaussian Fit")
%% high geometric factor peak
% This uses the function in no_gauss_sep_peak.m file

first = (1:1000);
figure;
[scat_plot] = no_gauss_sep_peak(textfile,first)
title("High Geometric Factor Peak")
%% INMS path
% This segment of code plots the trajectory of the CubeSat during which the
% INMS collected data

disp("Plotting Trajectory")
figure; 
date = importdata(textfile,' ');
% extracting location data from files
lon = date.data(:,1);
lat = date.data(:,2);
% plotting routine
scatter(lon, lat, "b*")
xlim([-180 180])
ylim([-90 90])
xlabel("longitude")
ylabel("latitude")
title(textfile)
hold on;
load coastlines.mat;
plot(coastlon, coastlat)
box on
hold off
title("INMS Path")

%% Path overlayed onto wind vector field
% This uses the function in HWM_vectorfield.m file

ap = 3; % Ap value
figure;
[vector_field] = HWM_vectorfield(textfile,ap)
title("HWM Wind Vector Field with CubeSat Path")

%% Path with wind vector field and density contours
% This uses the function in densityANDwind.m file

f107A = 73.5; % F10.7 Average 
f107D = 76.6; % F10.7 Daily
figure;
[contour_vector] = densityANDwind(textfile, f107A, f107D, ap)
title("HWM Wind Vector Field and NRLMSISE Density Contours with Path")

%% Subplot of full run counts and wind field
% This subplot compares the full run INMS count with the wind direction
% relative to the CubeSat's look direction

figure;
pos1= [0.1,0.3,0.3,0.3]; % Subplot position
subplot('Position',pos1)
[scat_plot] = no_gauss_sep_peak(textfile,[1:length(date.data(:,4))])
title("INMS counts")
pos2=[0.5,0.15,0.4,0.6]; % Subplot position
subplot('Position', pos2)
[contour_vector] = densityANDwind(textfile, f107A, f107D, ap)
title("Wind Field")
sgtitle('COMPARING FULL RUN COUNTS AND WIND DIRECTION')
 

