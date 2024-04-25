%% ADDING PARAMETERS TO THE BATCH
% (PREPROCESSING OPTION)
% 

%% CONDITIONS
% Our design consists of a two-session pre- and post-training acquisitions
nconditions = n_sessions; % treats each session as a different condition
batch.Setup.conditions.names = [{'average'},{'T1'},{'T2'}]; % three cells: one for average activity, one for T1 and one for T2

% Entering the conditions 
for ncond = 1
    for nsub = 1:n_subs
        for nses = 1:n_sessions
            batch.Setup.conditions.onsets{ncond}{nsub}{nses} = 0;
            batch.Setup.conditions.durations{ncond}{nsub}{nses} = inf;
        end
    end
end     % rest condition (all sessions)

for ncond = 1:nconditions
    for nsub = 1:n_subs
        for nses = 1:n_sessions
            batch.Setup.conditions.onsets{1+ncond}{nsub}{nses} = [];
            batch.Setup.conditions.durations{1+ncond}{nsub}{nses} = [];
        end
    end
end

for ncond = 1:nconditions
    for nsub = 1:n_subs
        for nses = ncond
            batch.Setup.conditions.onsets{1+ncond}{nsub}{nses} = 0;
            batch.Setup.conditions.durations{1+ncond}{nsub}{nses} = inf;
        end
    end
end % session-specific conditions (T1 and T2)

% Allowing missing data
% Allow subjects with missing condition data (empty onset/duration fields in *all* of the sessions),
batch.Setup.conditions.missingdata = 1; % Set to 0 if all the subjects have the respective data

% %% FIRST-LEVEL COVARIATES
% % In this section we want to express the covariates that we want to
% % includes as covariates of no interest in our first-level analysis
n_cov = 3; % number of 1st level covariates 
batch.Setup.covariates.names = {'realignment','QC_timeseries','scrubbing'};
% 
% 
% Building covariates file structure
session_names = {'ses-pretraining','ses-posttraining'};
% 
for i_cov = 1:n_cov
    for i_sub = 1:numel(sel_subs)
        for i_sess = 1:n_sessions

            curr_folder = fullfile(cwd,sel_subs{i_sub},session_names{i_sess},'tmp/preproc_func');

            if i_cov == 1
                cov_files{i_cov}{i_sub}{i_sess} = {fullfile(curr_folder,['rp_' sel_subs{i_sub} '_ses-01_task-rest_bold.txt'])}; % realignment
            elseif i_cov == 2
                cov_files{i_cov}{i_sub}{i_sess} = {fullfile(curr_folder,['art_regression_timeseries_au' sel_subs{i_sub} '_ses-01_task-rest_bold.mat'])}; % QC_timeseries
            elseif i_cov == 3
                cov_files{i_cov}{i_sub}{i_sess} = {fullfile(curr_folder,['art_regression_outliers_au' sel_subs{i_sub} '_ses-01_task-rest_bold.mat'])}; % scrubbing 
            end

        end
    end
end

% Setup.covariates.files: covariates.files{ncovariate}{nsub}{nses} char array of covariate file 
batch.Setup.covariates.files = cov_files;
batch.Setup.covariates.add = 0; % Set to 1 if you want to add covariates

%% MASKS
% 
for i_sub = 1:numel(sel_subs)
    for i_sess = 1:n_sessions

        curr_folder = fullfile(cwd,sel_subs{i_sub},session_names{i_sess},'tmp/preproc_anat');

        greymask_files{i_sub}{i_sess} = {fullfile(curr_folder,['wc1c' sel_subs{i_sub} '_ses-01_T1w.nii'])}; % wc1csub-04_ses-01_T1w
        whitemask_files{i_sub}{i_sess} = {fullfile(curr_folder,['wc2c' sel_subs{i_sub} '_ses-01_T1w.nii'])};
        CSFmask_files{i_sub}{i_sess} = {fullfile(curr_folder,['wc3c' sel_subs{i_sub} '_ses-01_T1w.nii'])};
    end
end

batch.Setup.masks.Grey = greymask_files;
batch.Setup.masks.White = whitemask_files;
batch.Setup.masks.CSF = CSFmask_files;
%% ROIs 
% In this section we aim at entering the files corresponding to our ROIs.
% This regional data will be then used as seeds for the ROI-to-ROI and
% seed-based analyses

% ROI names
roi_names = {'Inferior_frontal_gyrus_L',...
            'Inferior_parietal_lobule_L',...
            'Inferior_parietal_lobule_R',...
            'Inferior_temporal_gyrus_L',...
            'Putamen&Insula_L',...
            'Putamen&Insula_R',...
            'medial_frontal_gyrus_BI'};
% 
n_rois = numel(roi_names); % Number of ROIs that we want to add
batch.Setup.rois.names = roi_names; % note: names of new ROIs ONLY here
% 
% Entering the files
for i_sub = 1:numel(sel_subs)
    for i_sess = 1:n_sessions

        curr_folder = fullfile(cwd,sel_subs{i_sub},session_names{i_sess},'tmp/preproc_anat');
% 
%         roi_files{1}{i_sess}{i_sub} = fullfile(curr_folder,['wc1c' sel_subs{i_sub} '_ses-01_T1w.nii']);
%         roi_files{2}{i_sess}{i_sub} = fullfile(curr_folder,['wc2c' sel_subs{i_sub} '_ses-01_T1w.nii']);
%         roi_files{3}{i_sess}{i_sub} = fullfile(curr_folder,['wc3c' sel_subs{i_sub} '_ses-01_T1w.nii']);
        roi_files{1}{i_sess}{i_sub} = fullfile(roi_dir,'Inferior_frontal_gyrus_L.nii');
        roi_files{2}{i_sess}{i_sub} = fullfile(roi_dir,'Inferior_parietal_lobule_L.nii');
        roi_files{3}{i_sess}{i_sub} = fullfile(roi_dir,'Inferior_parietal_lobule_R.nii');
        roi_files{4}{i_sess}{i_sub} = fullfile(roi_dir,'Inferior_temporal_gyrus_L.nii');
        roi_files{5}{i_sess}{i_sub} = fullfile(roi_dir,'Putamen&Insula_L.nii');
        roi_files{6}{i_sess}{i_sub} = fullfile(roi_dir,'Putamen&Insula_R.nii');
        roi_files{7}{i_sess}{i_sub} = fullfile(roi_dir,'medial_frontal_gyrus_BI.nii');

    end
end


batch.Setup.rois.files = roi_files;

batch.Setup.rois.add = 0; % Set to 1 if we want to add ROIs to the already-existing ones

%% SECOND-LEVEL COVARIATES
% In this section we want to specify the covariates that are going to be
% included in our 2nd-level analysis

% Adding the second-level covariate group (Memory vs Strategy)
% CREATE_secondlevel_covariate_group;