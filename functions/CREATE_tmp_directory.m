%% TMP folders creator

% dir_info = information about the subs folder inside Data (so that it knows the subjects we already ahve the data of)
% sub_names = names of the subjects whose data are present

%function [dir_info, sub_names]= create_tmp_directory

cd('D:\Main_arithmetic\RS_analysis\Data') % currect directory
cwd = pwd;
new_dir = 'tmp'; % name of the folder where the output of the preprocessing will be stored

dir_info = dir('sub-*'); % extracting all the folders starting with "sub-"
sub_names = {dir_info.name}; % storing them inside a cell array

for sub = 1:numel(sub_names)
    sub_num = sub_names{sub};

    if isfolder([cwd '\' sub_num '\ses-pretraining'])
        cd([cwd '\' sub_num '\ses-pretraining']) % entering subject's folder % ses-pretraining
        
        % rmdir(new_dir,'s')

        if not(isfolder(new_dir))
            mkdir(new_dir)
        else 
            cd(new_dir)
            mkdir('preproc_anat')
            mkdir('preproc_func')
        end

    end 

    if isfolder([cwd '\' sub_num '\ses-posttraining'])
        cd([cwd '\' sub_num '\ses-posttraining']) % entering subject's folder % ses-pretraining
        
        % rmdir(new_dir,'s')

        if not(isfolder(new_dir))
            mkdir(new_dir)
        else
            cd(new_dir)
            mkdir('preproc_anat')
            mkdir('preproc_func')
        end

    end 
end

disp(' ')
disp('TMP folder creator - DONE')
%end
