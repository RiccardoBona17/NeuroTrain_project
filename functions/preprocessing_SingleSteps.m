%% SINGLE-STEPS PREPROCESSING - RS ANALYSIS
% This function takes the preprocessing starting step as input and create a
% list of preprocessing steps missing as output

function missing_steps = preprocessing_SingleSteps(last_step)

    steps_labels = {'functional_label_as_original'    % (1)
        'functional_realign&unwarp'                   % (2)
        'functional_center'                           % (3)
        'functional_slicetime'                        % (4)
        'functional_art'                              % (5)
        'functional_segment&normalize_direct'         % (6)
        'functional_label_as_mnispace'                % (7)
        'structural_center'                           % (8)
        'structural_segment&normalize'                % (9)
        'functional_smooth'                           % (10)
        'functional_label_as_smoothed'};              % (11)

    missing_steps = steps_labels(last_step:end); % insert the labels of the step that are missing
end