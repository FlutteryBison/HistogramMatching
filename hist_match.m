%Read the target image and convert it to YCbCr format
files = dir("images\target");
files = files([files.isdir] == false);

im_tar = imread([files(1).folder, filesep, files(1).name]);
im_tar_YCBCR = rgb2ycbcr(im_tar);

%Get the frequencies of intensity values for the target image.
%Do it now as it is ploted in for each input image so dont recalculate for
%each input.
hist_tar = get_freqs(im_tar_YCBCR(:,:,1),256);

%get all the input images
files = dir("images\inputs");
files = files([files.isdir] == false);
num_im = size(files,1);



% Perform histogram matching for each image
for im_idx = 1:num_im
    im_in = imread([files(im_idx).folder, filesep, files(im_idx).name]);

    %Convert the rgb image to YCbCr format
    im_in_YCBCR = rgb2ycbcr(im_in);
    
    %Get the equalised mappings for the input and the target
    im_in_eq = equalised_mappings(im_in_YCBCR(:,:,1),256);
    im_tar_eq = equalised_mappings(im_tar_YCBCR(:,:,1),256);
    
    %Get the final intensity mappings for the input image
    fin_map = histogram_match_mappings(im_in_eq,im_tar_eq);
    
    im_h = size(im_in_YCBCR,1);
    im_w = size(im_in_YCBCR,2);
    
    %Initialise the matrix that will store the new intensity values
    new_y = zeros(im_h,im_w);
    
    %Change the intensity values using the mappings calculated
    for i = 1:im_h
        for j = 1:im_w
            new_y(i,j) = fin_map(im_in_YCBCR(i,j),1);  
        end
    end

    
        
    %Concatinate the intensity values with the unchanged color values
    out = cat(3,new_y,im_in_YCBCR(:,:,2:3));
    %Convert back to rgb
    out_rgb = ycbcr2rgb(out);

    %Display result in its own figure
    figure(im_idx);
    
    sub_plot_tight(2,3,1)
    imshow(im_tar, 'border', 'tight');
    title("Target");

    sub_plot_tight(2,3,4)
    
    bar(hist_tar);

    sub_plot_tight(2,3,2)
    imshow(im_in, 'border', 'tight');
    title("Input");

    sub_plot_tight(2,3,5)
    hist = get_freqs(im_in_YCBCR(:,:,1),256);
    bar(hist);

    sub_plot_tight(2,3,3)
    imshow(out_rgb, 'border', 'tight');
    title("Output")

    sub_plot_tight(2,3,6)
    hist = get_freqs(out(:,:,1),256);
    bar(hist);
    

end
