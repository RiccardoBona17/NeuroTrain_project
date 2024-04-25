%% SECOND-LEVEL RESULTS 
% 

% Paths and directories
proj_dir = 'D:\Main_arithmetic\RS_analysis';

% Initializing variables
project_name = 'MAIN_PROJECT';
batch.filename = fullfile(proj_dir,project_name);

%% ADDING SECOND-LEVEL COVARIATE
% Adding the second-level covariate GROUPS (STRATEGY vs MEMORY)

% Coding for the subjects' group (empty codes = missing data)
% 1 = Memory
% 0 = Strategy

group_names = {'Strategy', 'Memory'};
groups_codes = [1 0 1 1 0 0 0 1 0 1 0 1 0 1 0 1 0 0 0 0 1 1 1 1 0 1]; % Memory
             % [0 1 0 0 1 1 1 0 1 0 1 0 1 0 1 0 1 1 1 1 0 0 0 0 1 0]  % Strategy

% Replace 0s with 2s
for i_grpcode = 1:numel(groups_codes)
    if groups_codes(i_grpcode) == 0
        groups_codes(i_grpcode) = 2; 
    end 
end 

groups_codes = groups_codes'; 

batch.Setup.subjects.group_names = group_names;
batch.Setup.subjects.groups = groups_codes;

batch.Setup.subjects.add = 1; % set to 0 if you want to define the covariates you are going to use in the analysis, keep to 1 if you want to add them to AllSubjects

% Run the batch to add the covariates
conn_batch(batch)
