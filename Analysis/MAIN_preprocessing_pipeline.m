%% PREPROCESSING
% This script runs the preprocessing steps we want to carry out by taking on already initiated projects.
% From this script we could create branches with specific preprocessing steps we aim to run
% (e.g. in case of missing steps).

if bool_preproc == 1 % run the code only if preprocessing is needed

    % Parameters
    n_slices = 75;
    voxelsize_func = 1.75; % size of a single isotropic voxel

    % Subjects selection
    % This option allows you to select a subset of subject on which you want to run the analysis on. In the case you have subjects with uncompleted
    % preprocessing, this is the right option to choose. However, if you want to add new subjects to the project and preprocess them, then
    % batch.Setup.add might suit better.

    % Unfolding
    batch.Setup.preprocessing.steps = {'default_mni'}; % default preprocessing pipeline (DIRECT segmentation and normalization)
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
else 
    disp(' ')
    disp('-- No preprocessing has been performed on the subjects --')
    disp(' ')
end
