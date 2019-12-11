function prob = mixture_prob(image, K, L, mask, verbose)
    % MIXTURE_PROB -- uses mask to identify pixels from an image that are used to estimate a mixture of K Gaussian components
    % Params:
    %  - image: the image
    %  - K: number of gaussian components
    %  - L: number of Expectation-Maximisation iterations
    %  - mask: mask to be used
    % Returns:
    %  - prob: probabilities of the colour of pixels*
    
    if nargin < 5
        verbose = 1;
    end
    
    % Store all pixels for which mask=1 in a Nx3 matrix
    [height, width, ~] = size(image);
    I = im2double(reshape(image, width*height, 3));
    Mvec = reshape(mask, width*height, 1);
    Ivec = I(Mvec==1, :);
    % Randomly initialize the K components using masked pixels
    seed = 14;
    rand("seed", seed);
    % Init covariance matrix
    cov = cell(K, 1);
    cov(:) = {rand * eye(3)};
    % Init means
    size(Ivec, 1)
    means_coord = randi(size(Ivec, 1), K, 1);
    means = Ivec(means_coord, :);
    % Init weights
    W = zeros(1, K);
    W(:) = 1/K;
    % Iterate L times
    G = zeros(size(Ivec, 1), K);
    for i = 1:L
        if verbose > 1
            fprintf('EM iter: %g\n', i)
        end
        % Expectation: Compute probabilities P_ik using masked pixels
        for k = 1:K
            dif = bsxfun(@minus, Ivec, means(k, :));
            G(:, k) = 1/sqrt((2 * pi)^3*det(cov{k})) * exp(-0.5*sum((dif*inv(cov{k}).*dif), 2));
        end
        P = bsxfun(@times, W, G);
        s = sum(P, 2);
        P = bsxfun(@rdivide, P, s);
        % Maximization: Update weights, means and covariances using masked pixels
        W = sum(P, 1) / size(P, 1);
        for k = 1:K
            if verbose > 1
                fprintf(' - %g\n', k)
            end
            means(k, :) = P(:, k)'*Ivec / sum(P(:, k), 1);
            dif = bsxfun(@minus, Ivec, means(k, :));
            cov{k} = (dif'*bsxfun(@times, P(:, k), dif)) / sum(P(:, k), 1);
        end
    end
    % Compute probabilities p(c_i) in Eq.(3) for all pixels I.
    G = zeros(size(I, 1), K);
    for k = 1:K
        dif = bsxfun(@minus, I, means(k, :));
        G(:, k) = 1/sqrt((2*pi)^3*det(cov{k})) * exp(-0.5*sum((dif*inv(cov{k}).*dif), 2));
    end
    prob = sum(bsxfun(@times, W, G), 2);
    prob = reshape(prob, height, width, 1);
end