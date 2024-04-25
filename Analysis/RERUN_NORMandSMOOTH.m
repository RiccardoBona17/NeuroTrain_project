%% NORMALISATION AND SMOOTHING 
% This script defines batch.Setup and fills it with relevant information. 
% You also have the option to select whether you want to process your subjects from the beginning or 
% start your analysis with already-preprocessed subjects

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
project_name = 'MAIN_PROJECT_norm&smooth';
new_project = 1; % Set 1 when creating a new project
overwrite = 1; % Set 1 to overwrite project: CAUTION!!
done = 1; 
TR = 2.03; % Repetition time
n_sessions = 2;

% Number of subjects in the project
n_subs = 1; % in case we are adding subjects, here we should specify the number of subjects being added

%% IF YOU WANT TO ADD SUBJECTS 
batch.Setup.add = 0; % Set to 1 if you want to add subjects to your projects

%% FINISHING PREPROCESSED THAT CRASHED??
preproc_crashed = 1; % Set to 1 when it crashed midway
subjects = 1; % fill with subjects IDX in case we want to work on a subset of our dataset
batch.subjects = subjects;

%% Subjects' selection and file arrangement
% Extract info about subjects from folders in Data

dir_info = dir('*sub-*');
sub_names = {dir_info.name};

% Select subjects
% Fill in the brackets with the subjects' interval you want to analyze (e.g. subjects 1,2,3 = sub_names(1:3))
sel_subs = sub_names(10); % repreprocess subjects: 04,05,10,11,12,12,15,16,19,20,21,23,24,25,26,27,28,29

% ORGANIZING DATA FILES
[AnatFiles,FuncFiles] = ORGANIZE_data_NORMandSMOOTH(sel_subs);

% Displaying design information
disp(['> ' num2str(n_sessions),' sessions in the project']);
disp(['> ' num2str(n_subs),' subjects in the project']);
disp(['> ' num2str(numel(sel_subs)),' subjects currently processed']);

%% SETTING UP THE BATCH (fillin it with relevant information)
% Prepares batch structure
% Name of the project (future name of the file .mat)
batch.filename = fullfile(proj_dir,project_name); 

% General parameters
batch.Setup.isnew = new_project;
batch.Setup.nsubjects = n_subs;
batch.Setup.RT = TR; % TR (seconds)

% Entering anatomical and functional files
batch.Setup.functionals = FuncFiles;
batch.Setup.structurals = AnatFiles;

%% PREPROCESSING - IN THE CASE OF PREPROCESSING CRASH, SELECT SPECIFIC PREPROCESSING STEPS TO RUN!! 
% Select the subjects you want to preprocess and run the analysis on
PREPROCESS_NORMandSMOOTH;


%% GENERAL OPTIONS
batch.Setup.overwrite = overwrite;
batch.Setup.done = done;

%% Running the batch
conn_batch(batch);