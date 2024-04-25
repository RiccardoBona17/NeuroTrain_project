%% GENERATING GROUP-LEVEL COVARIATE GROUPS

%% Adding the second-level covariate GROUPS (STRATEGY vs MEMORY)

batch.Setup.subjects.group_names = {'Strategy', 'Memory'};

% Coding for the subjects' group (empty codes = missing data)
% 1 = Memory
% 0 = Strategy
groups_codes = [1 0 1 1 0 NaN 0 0 1 0 NaN 1 0 1 0 1 0 1 NaN 0 0 0 0 1 1 1 1 0 1];

% Replace 0s with 2s

for i_grpcode = 1:numel(groups_codes)
    if groups_codes(i_grpcode) == 0
        groups_codes(i_grpcode) = 2; 
    end 
end 

groups_codes = groups_codes'; 

batch.Setup.subjects.groups = groups_codes;
% batch.Setup.subjects.descrip = {{'This variable indicates to which group each subject, except missing ones, is part of'}};



