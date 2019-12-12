function norm_cut(img, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth, scale_factor, image_sigma)
    % Params
    %  - img: image file name (without .jpg)
    %  - colour_bandwidth: color bandwidth
    %  - radius: maximum neighbourhood distance
    %  - ncuts_thresh: cutting threshold
    %  - min_area: minimum area of segment
    %  - max_depth: maximum splitting depth
    %  - scale_factor: image downscale factor
    %  - image_sigma: image preblurring scale

    I = imread([img '.jpg']);
    I = imresize(I, scale_factor);
    Iback = I;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I = imfilter(I, h);

    segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
    Inew = mean_segments(Iback, segm);
    I = overlay_bounds(Iback, segm);
    imwrite(Inew, ['result/norm/' img '_cb' strrep(num2str(colour_bandwidth), '.', '_') '_rad' strrep(num2str(radius), '.', '_') '_nct' strrep(num2str(ncuts_thresh), '.', '_') '_minar' strrep(num2str(min_area), '.', '_') '_md' strrep(num2str(max_depth), '.', '_') '.png'])
    imwrite(I, ['result/norm/' img '_cb' strrep(num2str(colour_bandwidth), '.', '_') '_rad' strrep(num2str(radius), '.', '_') '_nct' strrep(num2str(ncuts_thresh), '.', '_') '_minar' strrep(num2str(min_area), '.', '_') '_md' strrep(num2str(max_depth), '.', '_') 'seg.png'])
    figure();
    subplot(1,2,1); imshow(Inew);
    subplot(1,2,2); imshow(I);
end