%% MERGING THE PROJECTS

clear all 
close all

% Paths
addpath('D:\Main_arithmetic\RS_analysis\Functions');

% Moving to the projects directory
proj_dir = 'D:\Main_arithmetic\RS_analysis';
cd(proj_dir);

% loop
for i_proj = 7
    % Select subject number
    subject_number = i_proj;

    % Loading the MAIN project
    conn('load','main_project.mat');

    % Merging the MAIN and the side-project
    if i_proj > 9
        conn_merge(['sub-' num2str(subject_number) '_project.mat']);
    else
        conn_merge(['sub-0' num2str(subject_number) '_project.mat']);
    end

    % PROCESS TERMINED
    disp('  ');
    disp('!');

end
