%% DENOISING - resting state data (CONN toolbox)
clear all
close all

% Paths and directories 
proj_dir = 'D:\Main_arithmetic\RS_analysis';

% Init variables
project_name = 'MAIN_PROJECT';
bandpass_filter = [0.008 0.09];
done = 1; % Set to 0 if you want to fill in the batch without running it
overwrite = 1;

% Calling the batch 
batch.filename = fullfile(proj_dir,project_name);                   

% CONN Denoising   % Default options (uses White Matter + CSF + realignment + scrubbing + conditions as confound regressors); see conn_batch for additional options
batch.Denoising.filter = bandpass_filter;                        
batch.Denoising.done = done;
batch.Denoising.overwrite = overwrite;

% uncomment the following 3 lines if you prefer to run one step at a time:
conn_batch(batch); % runs Denoising step only



