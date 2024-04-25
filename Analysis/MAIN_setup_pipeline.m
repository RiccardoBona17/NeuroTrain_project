%% MAIN PIPELINE FOR RESTING-STATE ANALYSIS
% This script defines batch.Setup and fills it with relevant information.
% You also have the option to select whether you want to process your subjects from the beginning or
% start your analysis with already-preprocessed subjects

clear all
close all

% Paths and directories
addpath('D:\Main_arithmetic\RS_analysis\Analysis'); % Folder containing all the main scripts
addpath('D:\Main_arithmetic\RS_analysis\Functions'); % Folder containing functions as well as secondary scripts
cwd = 'D:\Main_arithmetic\RS_analysis\Data';
proj_dir = 'D:\Main_arithmetic\RS_analysis';
roi_dir = 'D:\Main_arithmetic\RS_analysis\ROIs\spherical ROIs from other analysis\NIFTI images';

% Change folder to data folder "cwd" 
cd(cwd); 

% Initializing variables
project_name = 'MAIN_PROJECT';
new_project = 0; % Set 1 when creating a new project
overwrite = 1; % Set 1 to overwrite project: CAUTION!!
done = 1;
TR = 2; % Repetition time
n_sessions = 2;

% Number of subjects in the project
n_subs = 26; % in case we are adding subjects, here we should specify the number of subjects being added

%% IF YOU WANT TO ADD SUBJECTS
batch.Setup.add = 0; % Set to 1 if you want to add subjects to your projects

%% PREPROC: YES or NO?
bool_preproc = 0; % set to 1 when preprocessing is needed

%% FINISHING PREPROCESSED THAT CRASHED??
preproc_crashed = 0; % Set to 1 when it crashed midway
%subjects = 1; % fill with subjects IDX in case we want to work on a subset of our dataset
%batch.subjects = subjects;

%% Subjects' selection and file arrangement
% Extract info about subjects from folders in Data
if preproc_crashed ~= 1

    dir_info = dir('*sub-*');
    sub_names = {dir_info.name};

    % Select subjects
    % Fill in the brackets with the subjects' interval you want to encompass in the analysis (e.g. subjects 1,2,3 = sub_names(1:3))
    sel_subs = sub_names([1:5,7:10,12:18,20:end]); % subjects excluded because no T2 => sub-06 - sub-11 - sub-19  

    % ORGANIZING DATA FILES
    % This function permits you to select and organize the anatomical and functional files in the required fashion.
    [AnatFiles,FuncFiles] = ORGANIZE_data_conn(bool_preproc,sel_subs);

    % Displaying design information
    disp(['> ' num2str(n_sessions),' sessions in the project']);
    disp(['> ' num2str(n_subs),' subjects in the project']);
    disp(['> ' num2str(numel(sel_subs)),' subjects currently processed']);
end

%% SETTING UP THE BATCH (fillin it with relevant information)
% Prepares batch structure
% Name of the project (future name of the file .mat)
batch.filename = fullfile(proj_dir,project_name);

if preproc_crashed ~= 1
    % General parameters
    batch.Setup.isnew = new_project;
    batch.Setup.nsubjects = n_subs;
    batch.Setup.RT = TR; % TR (seconds)

    % Entering anatomical and functional files
    batch.Setup.functionals = FuncFiles;
    batch.Setup.structurals = AnatFiles;


    %% ADDING PARAMETERS TO THE BATCH (CONDITIONS + ROI)
    % This script adds the parameters that we need to specify for the purposes of our analysis.
    ADD_batchparameters_conn;
end

%% PREPROCESSING - IN THE CASE OF PREPROCESSING CRASH, SELECT SPECIFIC PREPROCESSING STEPS TO RUN!!
% Select the subjects you want to preprocess and run the analysis on
MAIN_preprocessing_pipeline;

%% GENERAL OPTIONS
batch.Setup.overwrite = overwrite;
batch.Setup.done = done;

%% Running the batch
conn_batch(batch);
