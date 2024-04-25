%% ARRANGING DATA FOR THE BATCH
% This script takes up the data and remove unnecessary paths (e.g. the ones to "anat" and "func" folders and organize the useful paths properly)

% Select functional and anatomical files: tmp only
for curfile_func = 1:numel(FuncFiles_temp)

    if ismember('tmp',strsplit(FuncFiles_temp{curfile_func,1},'\'))
        FuncFiles_final = [FuncFiles_final; FuncFiles_temp(curfile_func,1)];
    end
end

for curfile_anat = 1:numel(AnatFiles_temp)

    if ismember('tmp',strsplit(AnatFiles_temp{curfile_anat,1},'\'))
        AnatFiles_final = [AnatFiles_final; AnatFiles_temp(curfile_anat,1)];
    end

end

% Arranging the datafiles (options that allows missing data) - ANATOMICAL
for i_file_anat = 1:length(AnatFiles_final)

    curr_file_anat = AnatFiles_final{i_file_anat};
    curr_file_split_anat = strsplit(curr_file_anat,'\');
    session_label_anat = curr_file_split_anat{6};
    subject_label_anat = curr_file_split_anat{5}(end-1:end);

    if session_label_anat == "ses-pretraining"
        AnatFiles{str2num(subject_label_anat)}{1} = curr_file_anat;

    elseif session_label_anat == "ses-posttraining"
        AnatFiles{str2num(subject_label_anat)}{2} = curr_file_anat;
    end 
 
end 

% Arranging the datafiles (options that allows missing data) - FUNCTIONAL
for i_file_func = 1:length(FuncFiles_final)
    curr_file_func = FuncFiles_final{i_file_func};
    curr_file_split_func = strsplit(curr_file_func,'\');
    session_label_func = curr_file_split_func{6};
    subject_label_func = curr_file_split_func{5}(end-1:end);

    if session_label_func == "ses-pretraining"
        FuncFiles{str2num(subject_label_func)}{1} = curr_file_func;

    elseif session_label_func == "ses-posttraining"
        FuncFiles{str2num(subject_label_func)}{2} = curr_file_func;
    end 
 
end

% Removing empty cells from data
FuncFiles = FuncFiles(~cellfun('isempty',FuncFiles));
AnatFiles = AnatFiles(~cellfun('isempty', AnatFiles));
