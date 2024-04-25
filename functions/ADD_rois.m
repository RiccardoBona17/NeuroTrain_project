%% ADDING ROIs to the main project
clear all
addpath('D:\Main_arithmetic\RS_analysis\Functions');
roi_dir = 'D:\Main_arithmetic\RS_analysis\Masks_ROIs';
cd(pwd);
project_name = 'main_project';
batch.filename = fullfile(pwd,project_name); % New conn_*.mat experiment name
batch.Setup.isnew = 0;
n_rois = 7;
n_sessions = 2;

% Select ROI names & files
roi_names = {'Inferior_frontal_gyrus_L',...
    'Inferior_parietal_lobule_L',...
    'Inferior_parietal_lobule_R',...
    'Inferior_temporal_gyrus_L',...
    'Putamen&Insula_L',...
    'Putamen&Insula_R',...
    'medial_frontal_gyrus_BI'};

roi_files = cellstr(spm_select('ExtFPList',roi_dir,'.nii'));

% Filling in the batch
batch.Setup.rois.names = roi_names; % note: names of new ROIs ONLY here
batch.Setup.rois.add = 0; % Set to 1 if we want to add ROIs to the already-existing ones


for nsess = 1:n_sessions
    for nroi = 1:n_rois
        batch.Setup.rois.files{nroi}{nsess} = roi_files(nroi); % note: locations of new ROI files ONLY here
    end
end

% Addign the second-level covariate group (Memory vs Strategy)
%CREATE_secondlevel_covariate_group;

conn_batch(batch)