function output =  conv2D(img_path, stride, is_same, filter)
    % Reading the image
    img = imread(img_path);
    img = rgb2gray(img);
    h=size(img, 1);
    w=size(img, 2);
    % Extracting filter size
    [ky, kx] = size(filter);
    
    if is_same==true
        %% The Same setting
        % Calculating the padding size
        py = floor((ky-1)/2);
        px = floor((kx-1)/2);
        % Padding the original image
        padded_image = [zeros(h, px) img zeros(h, px)];
        padded_image = [zeros(py, w+2*px); padded_image; zeros(py, w+2*px)];
        % Defining the output
        output = zeros(floor((h-ky+2*py)/stride+1), floor((w-kx+2*px)/stride+1));
        for row = 1:floor((h-ky+2*py)/stride+1)
            for col = 1:floor((w-kx+2*px)/stride+1)
                % Extracting the window on the padded image
                local = padded_image(stride*(row-1)+1:stride*(row-1)+1+ky-1, stride*(col-1)+1:stride*(col-1)+1+kx-1);
                % Doing the calculations
                conv = double(local) .* filter;
                output(row, col) = sum(conv, 'all');
            end
        end
        
    else
        %% The Valid setting
        % Defining the output
        output = zeros(floor((h-ky)/stride+1), floor((w-kx)/stride+1));
        for row = 1:floor((h-ky)/stride)+1
            for col = 1:floor((w-kx)/stride)+1
                % Extracting the window on the original image
                local = img(stride*(row-1)+1:stride*(row-1)+1+ky-1, stride*(col-1)+1:stride*(col-1)+1+kx-1);
                % Doing the calculations
                conv = double(local) .* filter;
                output(row, col) = sum(conv, 'all');
            end
        end
    end
    %% Creating the output file
    % Defining different filter for filter name estraction because filter name is not an input of this function
    sharpness = [0, -1, 0;
                 -1, 5, -1;
                 0, -1, 0];
    horizontal_edge = [-1, -1, -1;
                       0, 0, 0;
                       1, 1, 1];
    embossing = [2, 0, 0;
                 0, -1, 0;
                 0, 0, -1];
    gaussian = [1, 4, 7, 4, 1;
                4, 16, 26, 16, 4;
                7, 26, 41, 26, 7;
                4, 16, 26, 16, 4;
                1, 4, 7, 4, 1]*1/273;
    if isequal(filter, sharpness)
        filter_name = 'sharpness';
    elseif isequal(filter, horizontal_edge)
        filter_name = 'horizontalEdge';
    elseif isequal(filter, embossing)
        filter_name = 'embossing';
    elseif isequal(filter, gaussian)
        filter_name = 'gaussian';
    else
        filter_name = 'unknown'; 
    end
    
    if is_same==true
        same_stat = 'same';
    else
        same_stat = 'valid';
    end
    % Writing the output to the disc
    [pathstr, name, ext] = fileparts(img_path);
    output_name = strcat(['output_images/', name, '_', filter_name, '_', same_stat, '_', num2str(stride), '.jpg']);
    output = uint8(output);
    imwrite(output, output_name)
end

