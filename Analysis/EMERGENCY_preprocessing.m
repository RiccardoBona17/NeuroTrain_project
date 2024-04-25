%% PREPROCESSING (PROCESS STOPPED HALFWAY)
% This script runs the preprocessing steps we want to carry out by taking on already-initiated projects. 
% From this script we could create branches with specific preprocessing steps we aim to run 
% (e.g. in case of missing steps).

% Parameters
TR = 2.03;
n_slices = 75;
voxelsize_func = 1.75; % size of a single isotropic voxel

% Unfolding

%     steps_labels = {'functional_label_as_original'    % (1)
%         'functional_realign&unwarp'                   % (2)
%         'functional_center'                           % (3)
%         'functional_slicetime'                        % (4)
%         'functional_art'                              % (5)
%         'functional_segment&normalize_direct'         % (6)
%         'functional_label_as_mnispace'                % (7)
%         'structural_center'                           % (8)
%         'structural_segment&normalize'                % (9)
%         'functional_smooth'                           % (10)
%         'functional_label_as_smoothed'};              % (11)

batch.Setup.preprocessing.steps = {''};
batch.Setup.preprocessing.ta = TR-(TR/n_slices);
batch.Setup.preprocessing.voxelsize_func = [voxelsize_func voxelsize_func voxelsize_func];
batch.Setup.preprocessing.sliceorder = {[
    0
    1.045
    0.08
    1.125
    0.16
    1.205
    0.24
    1.285
    0.32
    1.365
    0.4
    1.445
    0.4825
    1.5275
    0.5625
    1.6075
    0.6425
    1.6875
    0.7225
    1.7675
    0.8025
    1.8475
    0.8825
    1.9275
    0.965
    0
    1.045
    0.08
    1.125
    0.16
    1.205
    0.24
    1.285
    0.32
    1.365
    0.4
    1.445
    0.4825
    1.5275
    0.5625
    1.6075
    0.6425
    1.6875
    0.7225
    1.7675
    0.8025
    1.8475
    0.8825
    1.9275
    0.965
    0
    1.045
    0.08
    1.125
    0.16
    1.205
    0.24
    1.285
    0.32
    1.365
    0.4
    1.445
    0.4825
    1.5275
    0.5625
    1.6075
    0.6425
    1.6875
    0.7225
    1.7675
    0.8025
    1.8475
    0.8825
    1.9275
    0.965	]*1000}; % slice order expressed in milliseconds (better suitability with multiband acquisition)
