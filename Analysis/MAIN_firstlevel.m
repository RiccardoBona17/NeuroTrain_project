%% FIRST-LEVEL ANALYSIS
%
clear all
close all

% Paths and directories 
proj_dir = 'D:\Main_arithmetic\RS_analysis';
data_dir = fullfile(proj_dir,'Data');

% Init variables
project_name = 'MAIN_PROJECT';
done = 1; % Set to 0 if you want to fill in the batch without running it
overwrite = 0;

% Setting up the batch
batch.filename = fullfile(proj_dir,project_name);

% Selecting the sources we want to analyze 
batch.Analysis.name = 'Seedbased_ROItoROI_relevant_ROIs';
batch.Analysis.sources = {
    % Spherical ROIs
    'sphere_inferior_parietal_lobule_LH.nii'
    'sphere_inferior_parietal_lobule_RH .nii'
    'sphere_inferior_temporal_gyrus_LH.nii'
    'sphere_insula_LH.nii'
    'sphere_insula_RH.nii'
    'sphere_medial_frontal_cortex_LH.nii'
    'sphere_middle_frontal_gyrus_LH.nii'
    'sphere_parahippocampus_T2overT1_G1.nii'
    % Functional ROIs
%     'Inferior_parietal_lobule_LH.nii' 
%     'Inferior_parietal_lobule_RH .nii'
%     'Inferior_temporal_gyrus_LH.nii'  
%     'Insula_LH.nii'                   
%     'Insula_RH.nii'                   
%     'Medial_frontal_cortex_LH.nii'
%     'Middle_frontal_gyrus_LH.nii'
%     'Parahippocampal_area_RH_T2overT1_G1.nii'
    % Anatomical ROIs
    %'atlas'
    'angular_gyrus_LH'
    'angular_gyrus_RH'
    };

% General options 
batch.Analysis.done = 1;
batch.Analysis.overwrite = overwrite;

% Run all analyses
conn_batch(batch);
