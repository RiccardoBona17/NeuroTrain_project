%% COPY OF FUNCs AND FMAPs files in TMP folder

%function copy_files_preproc

cd('D:\Main_arithmetic\RS_analysis\Data');
anatdir = 'anat';
funcdir = 'func';
% fmapdir = 'fmap';
tmpdir_func = 'tmp';
cwd = pwd;
session = 'ses-pretraining'; % ses-posttraining
dir_info = dir('*sub-*');
sub_names = {dir_info(end-2:end).name}; % select subjects you want to work on

str.file = {'*.nii'};
sub_fold = {'preproc_func','preproc_anat'};

for sub = 1:numel(sub_names)

    if isfolder([cwd '\' sub_names{sub} '\' session]) 

        cd(['D:\Main_arithmetic\RS_analysis\Data\' sub_names{sub} '\' session]); 

%         str.file = {'*.nii'};

        for i = 1:2 % just because we copy files from three different folders

            %             if i == 1 % fmaps
            %                 if isempty([cd '\' fmapdir]) == 0
            %                     str.folder{i} = fmapdir;
            %                     fn.orig(i) = strcat(str.folder(1),'\',str.file);
            %                 end

            if i == 1 % functional
                if isempty([cd '\' funcdir]) == 0
                    str.folder{i} = funcdir;
                    fn.orig(i) = strcat(str.folder(i),'\',str.file); % path used as filter in cellfun
                end
            elseif i == 2 % anatomical
                if isempty([cd '\' anatdir]) == 0
                    str.folder{i} = anatdir;
                    fn.orig(i) = strcat(str.folder(i),'\',str.file);
                end
            end

            % str.file = {'*.nii'};
            fn.dest = repelem({[tmpdir_func '\' sub_fold{i}]},numel(fn.orig(i))); % here, it wants as many destination folders as the numebr of files you want to move

            cellfun(@copyfile,fn.orig(i),fn.dest(1),"f"); % package cellfun (specific for cells), function @copyfile
            %cellfun(@copyfile,fn.orig(i),fn.dest(),"f");

        end
    end
end
%end
