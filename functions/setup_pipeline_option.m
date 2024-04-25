%% MAIN PIPELINE FOR RESTING-STATE ANALYSIS (PREPROCESSING MODIFIED OPTION)
% This script defines batch.Setup and fills it with relevant information. 
% You also have the option to select whether you want to process your
% subjects from the beginning or start your analysis with
% already-preprocessed subjects

clear all
close all

% Paths and directories
addpath('D:\Main_arithmetic\RS_analysis\Analysis');
addpath('D:\Main_arithmetic\RS_analysis\Functions');
cd('D:\Main_arithmetic\RS_analysis\Data');
cwd = 'D:\Main_arithmetic\RS_analysis\Data';
proj_dir = 'D:\Main_arithmetic\RS_analysis';
roi_dir = 'D:\Main_arithmetic\RS_analysis\Masks_ROIs';

% Initializing variables
project_name = 'MAIN_PROJECT';
new_project = 1; % Set 1 when creating a new project
overwrite = 1; % Set 1 to overwrite project: CAUTION!!
done = 1; 
n_subs = 2;
TR = 2.03; % Repetition time
n_sessions = 2;

%% Subjects' selection and file arrangement
% Selecting the number of subjects we want to analyze now

% Extract info about subjects from folders in Data
dir_info = dir('*sub-*');
sub_names = {dir_info.name};

% Select subjects
sel_subs = sub_names([11,13]); % Fill in the brackets with the subjects' interval you want to analyze (e.g. subjects 1,2,3 = sub_names(1:3))
% batch.Setup.add = 0; % remember to set it to 0 if the project is new

%% UNPREPROCESSED OR ALREADY-PREPROCESSED SUBJECTS??
% At this point we should select whether our data have already been
% preprocessed, thus moving right toward denoising or not, which means we
% will run preprocessing first.

already_preprocessed = 0; % Set to 0 if subjects present only raw data files
% subjects = 4; % if already_preprocessed = 1, Select subjects we want to complete preprocessing of (e.g. If we initially have 4 subjects and we want to preprocess the first two only then subjects = [1 2])
% batch.subjects = subjects;

%% ORGANIZING DATA FILES
[AnatFiles,FuncFiles] = ORGANIZE_data_conn(already_preprocessed,sel_subs);

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

%% ADDING PARAMETERS TO THE BATCH (CONDITIONS + ROI + MASKS + 2ND-LEVEL COVARIATES)
% This script adds the parameters that we need to specify for the purposes
% of our analysis.

% ADD_parameters_conn_preproc_option; % script, not a function
ADD_batchparameters_conn; % script, not a function

%% PREPROCESSING
if already_preprocessed == 0
    % Select the subjects you want to preprocess and run the analysis on
    PREPROCESSING_allsubs;
elseif already_preprocessed == 1
    PREPROCESSING_alreadystarted;
end
%% GENERAL OPTIONS
batch.Setup.overwrite = overwrite;
batch.Setup.done = done;
    
%% Running the batch
conn_batch(batch);