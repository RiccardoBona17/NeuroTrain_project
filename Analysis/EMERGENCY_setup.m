%% EMERGENCY PIPELINE FOR RESTING-STATE ANALYSIS
% This script defines batch.Setup and fills it with relevant information.
% But in the case something screwed up the preprocessing of new subjects

clear all
close all

% Paths and directories
addpath('D:\Main_arithmetic\RS_analysis\Analysis'); % Folder containing all the main scripts
addpath('D:\Main_arithmetic\RS_analysis\Functions'); % Folder containing functions as well as secondary scripts
cd('D:\Main_arithmetic\RS_analysis\Data');
cwd = 'D:\Main_arithmetic\RS_analysis\Data';
proj_dir = 'D:\Main_arithmetic\RS_analysis';
roi_dir = 'D:\Main_arithmetic\RS_analysis\Masks_ROIs'; 

% Initializing variables
project_name = 'MAIN_PROJECT';
new_project = 0; % Set 1 when creating a new project
overwrite = 1; % Set 1 to overwrite project: CAUTION!!
done = 1; 

%% WHEN CONCLUDING SUBJECTS' PREPROCESSING
subjects = []; % array of subjects we want to complete preprocessing of

%% SETTING UP THE BATCH (fillin it with relevant information)
% Prepares batch structure
% Name of the project (future name of the file .mat)
batch.filename = fullfile(proj_dir,project_name); 

% Subjects
batch.subjects = subjects;

% General parameters
batch.Setup.isnew = new_project;

%% PREPROCESSING
% Select the subjects you want to preprocess and run the analysis on
EMERGENCY_preprocessing;

%% GENERAL OPTIONS
batch.Setup.overwrite = overwrite;
batch.Setup.done = done;

%% Running the batch
conn_batch(batch);