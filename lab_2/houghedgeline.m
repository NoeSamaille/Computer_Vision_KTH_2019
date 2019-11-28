function [linepar acc] = ...
    houghedgeline(pic, scale, gradmagnthreshold, nrho, ntheta, nlines, verbose)

    % HOUGHEDGELINE -- Detect edgesin pic then apply hough transform
    % Params:
    %  - pic: grey-level image
    %  - scale: scale at which edges are detected
    %  - gradmagnthreshold: threshold of the gradient magnitude
    %  - nrho: number of accumulators in the ? direction
    %  - ntheta: number of accumulators in the ? direction
    %  - nlines: number of lines to be extracted
    %  - verbose: degree of extra information and figures that will be shown.    
    % Returns:
    %  - linepar: list of (nlines,2) parameters for each line segment
    %  - acc: accumulator matrix of the Hough transform
    
    curves = extractedge(pic, scale, gradmagnthreshold, 'same');
    mag = sqrt(Lv(pic, 'same', 'centered'));
    [linepar, acc] = houghline(curves, mag, nrho, ntheta, gradmagnthreshold, nlines, verbose);
    if verbose >= 1
        drawlines(linepar, pic);
    end
end
