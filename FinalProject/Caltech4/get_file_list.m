function [image_paths, file_names, n_files] = get_file_list(folder, category)
% for the training data the ImageSets folder is used (without annotation),
% and for the test data the Annotation folder is used (with annotation).
% Because of the difference in text file, they need different approaches to
% obtain the data. 
switch folder
    case "train"
        filename = strcat('ImageSets/', category, '_train.txt');
        file_open = fopen(filename);
        formatSpec = '%22c';
        A = strcat(strsplit(fscanf(file_open,formatSpec), '\n'), '.jpg');
        n_files = length(A);
        fclose(file_open);
        file_names = 0;

        % make a list with all the file names in that folder
        image_paths = fullfile('ImageData', A); 
    case "test"
        filename = strcat('Annotation/', category, '_test.txt');
        file_open = fopen(filename, 'r');
        formatSpec = '%22c';
        A = fscanf(file_open,formatSpec);
        B = strsplit(A, '\n');
        n_files = length(B);
 
        % for every line, split the filename from the annotation
        for j=1:(n_files - 1)
           splitted = strsplit(char(B(j)), ' ');
           file_names(j) = splitted(1);
        end
        D = strcat(file_names, '.jpg');
        fclose(file_open);
        % make a list with all the file names in that folder
        image_paths = fullfile('ImageData', D); 
end