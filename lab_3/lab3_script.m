% Part 2: Mean-shift segmentation

% Part 3: Mean-shift segmentation

% Part 4: Normalized cut

% colour_bandwidth = 10.0; % color bandwidth
% radius = 3;              % maximum neighbourhood distance
% ncuts_thresh = 2;        % cutting threshold
% min_area = 300;          % minimum area of segment
% max_depth = 8;           % maximum splitting depth
% scale_factor = 0.4;      % image downscale factor
% image_sigma = 2.0;       % image preblurring scale
% norm_cut('tiger1', colour_bandwidth, radius, ncuts_thresh, min_area, max_depth, scale_factor, image_sigma)

% Part 5: Graph cut

scale_factor = 0.5;          % image downscale factor
area = [80, 110, 570, 300];  % image region to train foreground with
K = 1;                      % number of mixture components
alpha = 13.0;                % maximum edge cost
sigma = 100.0;                % edge cost decay factor
graph_cut('tiger3', scale_factor, area, K, alpha, sigma)
