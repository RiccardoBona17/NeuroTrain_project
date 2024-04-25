%% ADDING PARAMETERS TO THE BATCH (JUST CONDITIONS + ROIs)
% Folder containing the ROI files

%% CONDITIONS
% Our design consists of a two-session pre- and post-training acquisitions
nconditions = n_sessions; % treats each session as a different condition
batch.Setup.conditions.names = [{'average'},{'T1'},{'T2'}];

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

%% ROIs
% In this section we aim at entering the files corresponding to our ROIs.
% This regional data will be then used as seeds for the ROI-to-ROI and seed-based analyses

% folder names of the sessions
session_names = {'ses-pretraining','ses-posttraining'};
% ROI names
% Extract ROI names from file in the ROI folder
cd(roi_dir)
roi_imported = {dir('10mm*').name}';

n_rois = numel(roi_imported); % Number of ROIs that we want to add

% Creating ROI-filled structure that will be entered in the batch

for i_roi = 1:n_rois

    roi_files{i_roi} = fullfile(roi_dir,[roi_imported{i_roi}]);

end

batch.Setup.rois.names = roi_imported; % note: names of new ROIs ONLY here
batch.Setup.rois.files = roi_files;
batch.Setup.rois.add = 1; % Set to 1 if we want to add ROIs to the already-existing ones

%% IF DATA IS ALREADY-PREPROCESSED, WE ALSO NEED MASKS, FIRST-LEVEL COVARIATES

if bool_preproc == 0 % no preproc needed, files already present
    %% FIRST-LEVEL COVARIATES
    % % In this section we want to express the covariates that we want to
    % % include as covariates of no interest in our first-level analysis
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

    batch.Setup.covariates.files = cov_files;
    batch.Setup.covariates.add = 0; % Set to 1 if you want to add covariates

    %% MASKS
    % here we add the anatomical segmentations of the three main tissues, which
    % will also be used as ROIs.

    for i_sub = 1:numel(sel_subs)
        for i_sess = 1:n_sessions

            curr_folder = fullfile(cwd,sel_subs{i_sub},session_names{i_sess},'tmp/preproc_anat');

            greymask_files{i_sub}{i_sess} = fullfile(curr_folder,['wc1c' sel_subs{i_sub} '_ses-01_T1w.nii']); % wc1csub-04_ses-01_T1w
            whitemask_files{i_sub}{i_sess} = fullfile(curr_folder,['wc2c' sel_subs{i_sub} '_ses-01_T1w.nii']);
            CSFmask_files{i_sub}{i_sess} = fullfile(curr_folder,['wc3c' sel_subs{i_sub} '_ses-01_T1w.nii']);
        end
    end

    batch.Setup.masks.Grey = greymask_files;
    batch.Setup.masks.White = whitemask_files;
    batch.Setup.masks.CSF = CSFmask_files;

end