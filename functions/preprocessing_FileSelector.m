%% SELECTING FILES ACCORDING TO THE PREPROCESSING STEP NEEDED
% This script takes up the preprocessing step number and select the right
% files to enter insdie the batch 

% starting_step = variable indicating the preprocessing step it starts with
% sub_names = cell array containing all the sub-xx codes denoting each subject


%                 'functional_label_as_original'                % (1)
%                 'functional_realign&unwarp'                   % (2)
%                 'functional_center'                           % (3)
%                 'functional_slicetime'                        % (4)
%                 'functional_art'                              % (5)
%                 'functional_segment&normalize_direct'         % (6)
%                 'functional_label_as_mnispace'                % (7)
%                 'structural_center'                           % (8)
%                 'structural_segment&normalize'                % (9)
%                 'functional_smooth'                           % (10)
%                 'functional_label_as_smoothed'};              % (11)

if starting_step == 1 || starting_step == 2

    for isub = 1+subjects_alreadydone:n_subs+subjects_alreadydone % range of subjects you want to analyse
        AnatFiles_temp = [AnatFiles_temp; cellstr(conn_dir([sub_names{isub} '_ses-01_T1w.nii']))];
        FuncFiles_temp = [FuncFiles_temp; cellstr(conn_dir([sub_names{isub} '_ses-01_task-rest_bold.nii']))];
    end

elseif starting_step == 3 || starting_step == 4

    for isub = 1+subjects_alreadydone:n_subs+subjects_alreadydone % range of subjects you want to analyse
        AnatFiles_temp = [AnatFiles_temp; cellstr(conn_dir([sub_names{isub} '_ses-01_T1w.nii']))];
        FuncFiles_temp = [FuncFiles_temp; cellstr(conn_dir(['u' sub_names{isub} '_ses-01_task-rest_bold.nii']))];
    end

elseif starting_step == 5 || starting_step == 6 % slicetimed-corrected functional data as input

    for isub = 1+subjects_alreadydone:n_subs+subjects_alreadydone % range of subjects you want to analyse
        AnatFiles_temp = [AnatFiles_temp; cellstr(conn_dir([sub_names{isub} '_ses-01_T1w.nii']))];
        FuncFiles_temp = [FuncFiles_temp; cellstr(conn_dir(['au' sub_names{isub} '_ses-01_task-rest_bold.nii']))];
    end

elseif starting_step == 7 || starting_step == 8 || starting_step == 9 % normalized functional data needed as input

    for isub = 1+subjects_alreadydone:n_subs+subjects_alreadydone % range of subjects you want to analyse
        AnatFiles_temp = [AnatFiles_temp; cellstr(conn_dir([sub_names{isub} '_ses-01_T1w.nii']))];
        FuncFiles_temp = [FuncFiles_temp; cellstr(conn_dir(['wau' sub_names{isub} '_ses-01_task-rest_bold.nii']))];
    end

elseif starting_step == 10 % normalized functional and structural data needed as input

    for isub = 1+subjects_alreadydone:n_subs+subjects_alreadydone % range of subjects you want to analyse
        AnatFiles_temp = [AnatFiles_temp; cellstr(conn_dir(['wc0c' sub_names{isub} '_ses-01_T1w.nii']))];
        FuncFiles_temp = [FuncFiles_temp; cellstr(conn_dir(['wau' sub_names{isub} '_ses-01_task-rest_bold.nii']))];
    end

elseif starting_step == 11 % smoothed functional and structural data needed as input

    for isub = 1+subjects_alreadydone:n_subs+subjects_alreadydone % range of subjects you want to analyse
        AnatFiles_temp = [AnatFiles_temp; cellstr(conn_dir(['wc0c' sub_names{isub} '_ses-01_T1w.nii']))];
        FuncFiles_temp = [FuncFiles_temp; cellstr(conn_dir(['swau' sub_names{isub} '_ses-01_task-rest_bold.nii']))];
    end

end
