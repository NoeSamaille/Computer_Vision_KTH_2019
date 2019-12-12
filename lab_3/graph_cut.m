function graph_cut(img, scale_factor, area, K, alpha, sigma)
    % Params
    %  - img: image file name (without .jpg)
    %  - scale_factor: image downscale factor
    %  - area: image region to train foreground with
    %  - K: number of mixture components
    %  - alpha: maximum edge cost
    %  - sigma: edge cost decay factor

    I = imread([img '.jpg']);
    I = imresize(I, scale_factor);
    Iback = I;
    area = int16(area*scale_factor);
    [ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);

    Inew = mean_segments(Iback, segm);
    I = overlay_bounds(Iback, segm);
    imwrite(Inew, ['result/graph/' img '_sf' strrep(num2str(scale_factor), '.', '_') '_k' num2str(K) '_alpha' strrep(num2str(alpha), '.', '_') '_sigma' strrep(num2str(sigma), '.', '_') '.png'])
    imwrite(I, ['result/graph/' img '_sf' strrep(num2str(scale_factor), '.', '_') '_k' num2str(K) '_alpha' strrep(num2str(alpha), '.', '_') '_sigma' strrep(num2str(sigma), '.', '_') '_seg.png'])
    imwrite(prior, ['result/graph/' img '_sf' strrep(num2str(scale_factor), '.', '_') '_k' num2str(K) '_alpha' strrep(num2str(alpha), '.', '_') '_sigma' strrep(num2str(sigma), '.', '_') '_prior.png'])
    subplot(2,2,1); imshow(Inew);
    subplot(2,2,2); imshow(I);
    subplot(2,2,3); imshow(prior);
end