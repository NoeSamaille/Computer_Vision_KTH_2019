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
    imwrite(Inew, ['result/norm/' img '_cb' num2str(colour_bandwidth) '_rad' num2str(radius) '_nct' num2str(ncuts_thresh) '_minar' num2str(min_area) '_md' num2str(max_depth) '.png'])
    imwrite(I, ['result/norm/' img '_cb' num2str(colour_bandwidth) '_rad' num2str(radius) '_nct' num2str(ncuts_thresh) '_minar' num2str(min_area) '_md' num2str(max_depth) 'seg.png'])
    figure();
    subplot(1,2,1); imshow(Inew);
    subplot(1,2,2); imshow(I);
end