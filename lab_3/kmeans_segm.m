function [segmentation, centers] = kmeans_segm(image, K, L, seed, naive_init)

  if nargin < 5
      naive_init = false;
  end

  rand("seed", seed);
  image = double(image);
  [width, height, ~] = size(image);
  Ivec = reshape(image, width*height, 3);
  segmentation = zeros(1, width*height);
  % Let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B).
  % Randomly initialize the K cluster centers
  
  if naive_init==true
    centers = randi(255, K, 3);
  else
    centers_coord = randi(width*height, K, 1);
    centers = Ivec(centers_coord, :);
  end
  
  % Compute all distances between pixels and cluster centers
  d = pdist2(Ivec, centers); % column k = distances between cluster k and all the image pixels
  
  % Iterate L times
  prev_centers = centers;
  for i=1:L
    % Assign each pixel to the cluster center for which the distance is minimum
    [~, c] = min(d, [], 2); % get argmin of each row of d matrix 
    segmentation = transpose(c);
    for k=1:K
      % Recompute each cluster center by taking the mean of all pixels assigned to it
        cluster = Ivec(segmentation == k, :);
        if size(cluster, 1) > 0
          centers(k, :) = mean(cluster);
        else
          fprintf("cluster %d is empty \n", k);
        end
    end
    
    if prev_centers == centers
      fprintf("center converged at iteration %d \n", i);
      break;
    end
    
    % Recompute all distances between pixels and cluster centers
    d = pdist2(Ivec, centers);
    
    prev_centers = centers;
  end
  
  % reshape to real form
  segmentation = reshape(segmentation, width, height);
end
