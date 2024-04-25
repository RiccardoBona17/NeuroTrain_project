%% SECOND-LEVEL Results in CONN

% General CONN settings
batch.Results.done = 1;
batch.Results.overwrite = 1;

% Name of the analysis
% batch.Results.name = "";
batch.Results.display = 0;
% batch.Results.saveas = "";
% batch.Results.foldername = "";

% Specifics ragarding the effects between subjects (the field must have the same length)
batch.Results.between_subjects.effect_names = "";
batch.Results.between_subjects.contrast = []; 

% Specifics ragarding the effects between conditions (the field must have the same length)
batch.Results.between_conditions.effect_names = "";
batch.Results.between_conditions.contrast = []; 