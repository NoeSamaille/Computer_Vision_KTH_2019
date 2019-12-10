% Part 2: Mean-shift segmentation

% Part 3: Mean-shift segmentation

% Part 4: Normalized cut

colour_bandwidth = 20.0; % color bandwidth
radius = 3;              % maximum neighbourhood distance
ncuts_thresh = 0.06;        % cutting threshold
min_area = 200;          % minimum area of segment
max_depth = 20;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale

norm_cut('tiger1', colour_bandwidth, radius, ncuts_thresh, min_area, max_depth, scale_factor, image_sigma)