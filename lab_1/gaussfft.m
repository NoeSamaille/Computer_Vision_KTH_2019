function pixels = gaussfft(pic, t)

    % 1. Generate a ?lter based on a sampled version of the Gaussian function.
    [xsize, ysize] = size(pic);
    [x, y] = meshgrid(-xsize/2:(xsize/2)-1, -ysize/2:(ysize/2)-1);
    g = (1/(2*pi*t)) * exp(-(x.^2+y.^2)/(2*t));

    % 2. Fourier transform the original image and the Gaussian ?lter.
    Fhat = fft2(pic);
    Ghat = fft2(fftshift(g));
    
    % 3. Multiply the Fourier transforms.
    res = Fhat .* Ghat;
    
    % 4. Invert the resulting Fourier transform.
    pixels = real(ifft2(res));

end