clear all
close all
clc

% Extracting list of images in the input_images folder
file_paths = dir('input_images');
% Counting the number of .jpg files
total_imgs = 0;
for i=1:length(file_paths)
    if  contains(file_paths(i).name, 'jpg')
        total_imgs = total_imgs + 1;
    end
end

img_idx = 1;
figure()
for i=1:length(file_paths)
    if  contains(file_paths(i).name, 'jpg')
        % Building the relational path
        img_path = strcat(['input_images/' file_paths(i).name]);
        %% Applying different filtering settings on the image
        % Sharpness filter (valid/stride=1)
        filter = [0, -1, 0;
                  -1, 5, -1;
                  0, -1, 0];
        output1 = conv2D(img_path, 1, false, filter);
        
        % Horizontal Edge filter (same/stride=2)
        filter = [-1, -1, -1;
                  0, 0, 0;
                  1, 1, 1];
        output2 = conv2D(img_path, 2, true, filter);
        
        % Embossing filter (valid/stride=3)
        filter = [2, 0, 0;
                  0, -1, 0;
                  0, 0, -1];
        output3 = conv2D(img_path, 3, false, filter);
        
        % Gaussian filter (same/stride=1)
        filter = [1, 4, 7, 4, 1;
                  4, 16, 26, 16, 4;
                  7, 26, 41, 26, 7;
                  4, 16, 26, 16, 4;
                  1, 4, 7, 4, 1]*1/273;
        output4 = conv2D(img_path, 1, true, filter);
        
        %% Plotting the results in one figure
        subplot(total_imgs, 5, img_idx);
        imshow(rgb2gray(imread(img_path)))
        img_idx = img_idx + 1;
        ylabel(file_paths(i).name);
        xlabel(strcat(['Size: ', regexprep(num2str(size(rgb2gray(imread(img_path)))), '  ', '×')]));
        if i == length(file_paths)
            xlabel({strcat(['Size: ', regexprep(num2str(size(rgb2gray(imread(img_path)))), '  ', '×')]), 'Original'});
        end
        
        subplot(total_imgs, 5, img_idx);
        imshow(output1)
        img_idx = img_idx + 1;
        xlabel(strcat(['Size: ', regexprep(num2str(size(output1)), '  ', '×')]));
        if i == length(file_paths)
            xlabel({strcat(['Size: ', regexprep(num2str(size(output1)), '  ', '×')]), 'Sharpness'});
        end
        
        subplot(total_imgs, 5, img_idx);
        imshow(output2)
        img_idx = img_idx + 1;
        xlabel(strcat(['Size: ', regexprep(num2str(size(output2)), '  ', '×')]));
        if i == length(file_paths)
            xlabel({strcat(['Size: ', regexprep(num2str(size(output2)), '  ', '×')]), 'Horizontal Edge'});
        end
        
        subplot(total_imgs, 5, img_idx);
        imshow(output3)
        img_idx = img_idx + 1;
        xlabel(strcat(['Size: ', regexprep(num2str(size(output3)), '  ', '×')]));
        if i == length(file_paths)
            xlabel({strcat(['Size: ', regexprep(num2str(size(output3)), '  ', '×')]), 'Embossing'});
        end
        
        subplot(total_imgs, 5, img_idx);
        imshow(output4)
        img_idx = img_idx + 1;
        xlabel(strcat(['Size: ', regexprep(num2str(size(output4)), '  ', '×')]));
        if i == length(file_paths)
            xlabel({strcat(['Size: ', regexprep(num2str(size(output4)), '  ', '×')]), 'Gaussian'});
        end
    end
end