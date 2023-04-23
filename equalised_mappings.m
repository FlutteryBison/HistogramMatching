function [mappings] = equalised_mappings(im,L)
%EQUALISE generates histogram equalisation mappings for the input image
%   Takes a matrix of intensity values and returns what each pixel value
%   must be mapped to for histogram equalisation.
%   Returns an L,1 vector where the index indicates the original value and
%   the value at that index indicates the mapping.

%   For RGB images, first convert the image to YCbCr and only equalise the
%   Y channel.
%   L is the number of intensity values a pixel can take. for 8 bit images
%   this is 256.


im_h = size(im,1);
im_w = size(im,2);
im_size = im_h*im_w;

%Create Histogram
hist = get_freqs(im+1,L);

%normalise histogram
hist_norm = hist/im_size;

%get the cumulative sum
hist_cum = cumsum(hist_norm);

%Calculate mappings for equalisation
mappings = L*hist_cum;
mappings = floor(mappings);


end

