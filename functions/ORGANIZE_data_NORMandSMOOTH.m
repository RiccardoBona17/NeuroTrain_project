function [AnatFiles,FuncFiles] = ORGANIZE_data_NORMandSMOOTH(sel_subs)

% Paths and directories
working_dir = 'D:\Main_arithmetic\RS_analysis\Data';
cd(working_dir)

% Init variables
AnatFiles_temp = {}; % Temporarily stores all the functional files, both from tmp and func dirs
FuncFiles_temp = {}; % Temporarily stores all the functional files, both from tmp and func dirs
AnatFiles_final = {};
FuncFiles_final = {}; % Final functional data, after selection
FuncFiles = {};
AnatFiles  = {};

% Unfolding
for i_sub = sel_subs
    % Entering structural and functional data
    AnatFiles_final = [AnatFiles_final; cellstr(conn_dir([i_sub{:} '_ses-01_T1w.nii']))]; % RAW ANATOMICAL 
    FuncFiles_final = [FuncFiles_final; cellstr(conn_dir(['au' i_sub{:} '_ses-01_task-rest_bold.nii']))]; % REALIGNED AND SLICE TIMED FILE
end

% Select functional and anatomical files: tmp only
for cur_file = 1:numel(FuncFiles_temp)

    if ismember('tmp',strsplit(FuncFiles_temp{cur_file,1},'\'))
        FuncFiles_final = [FuncFiles_final; FuncFiles_temp(cur_file,1)];
    end

    if ismember('tmp',strsplit(AnatFiles_temp{cur_file,1},'\'))
        AnatFiles_final = [AnatFiles_final; AnatFiles_temp(cur_file,1)];
    end

end


% Arranging the datafiles (options that allows missing data) - ANATOMICAL
specific_sequence = 'sub-';

for i_file_anat = 1:length(AnatFiles_final)

    curr_file_anat = AnatFiles_final{i_file_anat};
    curr_file_split_anat = strsplit(curr_file_anat,'\');
    sub_index = find(cellfun(@(x) strncmp(x, specific_sequence, length(specific_sequence)), curr_file_split_anat));
    subject_label_anat = curr_file_split_anat{sub_index(1)}(end-1:end);

    if ismember('ses-pretraining',curr_file_split_anat) % session_label_anat == "ses-pretraining"
        AnatFiles{str2double(subject_label_anat)}{1} = curr_file_anat;

    elseif ismember('ses-posttraining',curr_file_split_anat)   % session_label_anat == "ses-posttraining"
        AnatFiles{str2double(subject_label_anat)}{2} = curr_file_anat;
    end

end

% Arranging the datafiles (options that allows missing data) - FUNCTIONAL
for i_file_func = 1:length(FuncFiles_final)

    curr_file_func = FuncFiles_final{i_file_func};
    curr_file_split_func = strsplit(curr_file_func,'\');
    sub_index = find(cellfun(@(x) strncmp(x, specific_sequence, length(specific_sequence)), curr_file_split_func));
    subject_label_func = curr_file_split_func{sub_index(1)}(end-1:end);

    if ismember('ses-pretraining',curr_file_split_func)
        FuncFiles{str2num(subject_label_func)}{1} = curr_file_func;

    elseif ismember('ses-posttraining',curr_file_split_func)
        FuncFiles{str2num(subject_label_func)}{2} = curr_file_func;
    end

end

% Removing empty cells from data
FuncFiles = FuncFiles(~cellfun('isempty',FuncFiles));
AnatFiles = AnatFiles(~cellfun('isempty', AnatFiles));
end 