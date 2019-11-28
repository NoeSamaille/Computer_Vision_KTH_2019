function [linepar, acc] = ...
    houghline(curves, magnitude, nrho, ntheta, threshold, nlines, verbose)

    % HOUGHLINE -- determine linear approximations of a given number of
    % curves, using Hough transform
    % Params:
    %  - curves: polygons from which the transform is to be computed
    %  - magnitude: image with one intensity value per pixel (e.g. gradient magnitude)
    %  - nrho: number of accumulators in the ? direction
    %  - ntheta: number of accumulators in the ? direction
    %  - threshold: lowest value allowed for the given magnitude
    %  - nlines: number of lines to be extracted
    %  - verbose: degree of extra information and figures that will be shown.    
    % Returns:
    %  - linepar: list of (nlines,2) parameters for each line segment
    %  - acc: accumulator matrix of the Hough transform
    
    % Check if input appear to be valid
    assert(nrho>0);
    assert(ntheta>0);
    assert(nlines>0);
    % Allocate accumulator space
    acc = zeros(nrho, ntheta);
    % Define a coordinate system in the accumulator space
    D = sqrt(size(magnitude,1)^2+size(magnitude,2)^2);
    thetas = linspace(-pi/2, pi/2, ntheta);
    rhos = linspace(-D, D, nrho);
    % Loop over all the input curves
    insize = size(curves, 2);
    trypointer = 1;
    numcurves = 0;
    while trypointer <= insize
        % For each point on each curve
        polylength = curves(2, trypointer);
        numcurves = numcurves + 1;
        trypointer = trypointer + 1;
        for polyidx = 1:polylength
            x = curves(2, trypointer);
            y = curves(1, trypointer);
            trypointer = trypointer + 1;
            % Check if valid point with respect to threshold
            mag_xy = magnitude(round(x), round(y));
            if mag_xy >= threshold
                % Loop over a set of theta values
                for i = 1:ntheta
                    % Compute rho for each theta value
                    rho = x*cos(thetas(i)) + y*sin(thetas(i));
                    % Compute index values in the accumulator space
                    j = find(rhos < rho, 1, 'last');
                    % Update the accumulator
                    acc(j, i) = acc(j, i) + 1;
%                     acc(j, i) = acc(j, i) + log(mag_xy); % Question 10
%                     acc(j, i) = acc(j, i) + mag_xy; % Question 10
                end
            end
        end
    end
    if verbose >= 2
        figure();
        showgrey(acc);
    end
    % Extract local maxima from the accumulator
    [pos, value] = locmax8(acc);
    [~, indexvector] = sort(value);
    nmaxima = size(value, 1);
    % Delimit the number of responses if necessary
    if nmaxima < nlines
        nlines = nmaxima;
    end
    % Compute a line for each one of the strongest responses in the accumulator
    linepar = zeros(nlines, 2);
    for idx = 1:nlines
        rhoidxacc = pos(indexvector(nmaxima - idx + 1), 1);
        thetaidxacc = pos(indexvector(nmaxima - idx + 1), 2);
        linepar(idx, :) = [thetas(thetaidxacc) rhos(rhoidxacc)];
        if verbose >= 2
            fprintf('Line\n - rho: %g\n - theta %g)\n', rhos(rhoidxacc), thetas(thetaidxacc))
        end
    end
    % Overlay these curves on the gradient magnitude image
    if verbose >= 2
        drawlines(linepar, magnitude);
    end
end