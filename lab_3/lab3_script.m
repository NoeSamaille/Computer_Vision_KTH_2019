% Part 2: K-means segmentation

% K = 8;               % number of clusters used
% L = 500;              % number of iterations
% seed = 14;           % seed used for random initialization
% scale_factor = 1.0;  % image downscale factor
% image_sigma = 0.5;   % image preblurring scale
% I = imread('bildat_lab3/tiger1.jpg');
% I = imresize(I, scale_factor);
% Iback = I;
% d = 2*ceil(image_sigma*2) + 1;
% h = fspecial('gaussian', [d d], image_sigma);
%I = imfilter(I, h);
%kmeans_init(I, K, L, Iback, seed, false);

%display_kmeans(K, L, seed, scale_factor, image_sigma);

% Part 3: Mean-shift segmentation
% It is basically a call to mean_shift_example.m
% mean_shift();

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

% scale_factor = 0.5;          % image downscale factor
% area = [80, 110, 570, 300];  % image region to train foreground with
% K = 1;                      % number of mixture components
% alpha = 13.0;                % maximum edge cost
% sigma = 100.0;                % edge cost decay factor
% graph_cut('tiger3', scale_factor, area, K, alpha, sigma)
