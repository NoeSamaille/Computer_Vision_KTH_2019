function [segmentation, centers] = kmeans_segm(image, K, L, seed)
  rand("seed", seed);
  image = double(image);
  [width, height, ~] = size(image);
  Ivec = reshape(image, width*height, 3);
  segmentation = zeros(1, width*height);
  % Let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B).
  % Randomly initialize the K cluster centers
  centers_idx = randi(width*height, K, 1);
  centers = Ivec(centers_idx, :);
  
  % Compute all distances between pixels and cluster centers
  d = pdist2(Ivec, centers); % column k = distances between cluster k and all the image pixels
  
  % Iterate L times
  for i=1:L
    % Assign each pixel to the cluster center for which the distance is minimum
    [~, idk] = min(d, [], 2); % get argmin of each row of d matrix 
    segmentation = transpose(idk);

    % Recompute each cluster center by taking the mean of all pixels assigned to it
    for k=1:K
      cluster = Ivec(segmentation == k, :);
      if size(cluster, 1) > 0
        centers(k, :) = mean(cluster);
      end
    end
    
    % Recompute all distances between pixels and cluster centers
    d = pdist2(Ivec, centers);
  end
  
  % reshape to real form
  segmentation = reshape(segmentation, width, height);
end
