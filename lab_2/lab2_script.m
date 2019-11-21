% Part 1 - Difference operators - Question 1

tools = few256;

dx_simple = [-1 1; 0 0];
dy_simple = [-1 1; 0 0]';
dx_centered = [0 0 0; -0.5 0 0.5; 0 0 0];
dy_centered = [0 0 0;-0.5 0 0.5; 0 0 0]';
dx_roberts = [1 0; 0 -1];
dy_roberts = [0 1; -1 0];
dx_sobel = [-1 0 1; -2 0 2; -1 0 1];
dy_sobel = [-1 -2 -1; 0 0 0; 1 2 1];

dxtools_simple = conv2(tools, dx_simple, 'valid');
dytools_simple = conv2(tools, dy_simple, 'valid');
dxtools_centered = conv2(tools, dx_centered, 'valid');
dytools_centered = conv2(tools, dy_centered, 'valid');
dxtools_roberts = conv2(tools, dx_roberts, 'valid');
dytools_roberts = conv2(tools, dy_roberts, 'valid');
dxtools_sobel = conv2(tools, dx_sobel, 'valid');
dytools_sobel = conv2(tools, dy_sobel, 'valid');

figure();
subplot(2, 4, 1);
showgrey(dxtools_simple);
title('dxtools simple');
subplot(2, 4, 5);
showgrey(dytools_simple);
title('dytools simple');
subplot(2, 4, 2);
showgrey(dxtools_centered);
title('dxtools centered');
subplot(2, 4, 6);
showgrey(dytools_centered);
title('dytools centered');
subplot(2, 4, 3);
showgrey(dxtools_roberts);
title('dxtools roberts');
subplot(2, 4, 7);
showgrey(dytools_roberts);
title('dytools roberts');
subplot(2, 4, 4);
showgrey(dxtools_sobel);
title('dxtools sobel');
subplot(2, 4, 8);
showgrey(dytools_sobel);
title('dytools sobel');

% Part 2 - Point–wise thresholding of gradient magnitudes - Questions 2 & 3

gradmagntools = sqrt(Lv(tools, 'valid', 'sobel', false));
thresholds = [100 120 130 140 160 180 200];

figure();
subplot(1, 1, 1);
histogram(gradmagntools);
title('hist');

figure();
subplot(2, (length(thresholds)+1)/2, 1);
showgrey(gradmagntools);
title('Without thresholding');
for i=1:length(thresholds)
    subplot(2, (length(thresholds)+1)/2, 1+i);
    showgrey((gradmagntools - thresholds(i)) > 0);
    title(['threshold:' num2str(thresholds(i))]);
end

gradmagntools = sqrt(Lv(tools, 'valid', 'sobel', true));
figure();
subplot(2, (length(thresholds)+1)/2, 1);
showgrey(gradmagntools);
title('Without thresholding');
for i=1:length(thresholds)
    subplot(2, (length(thresholds)+1)/2, 1+i);
    showgrey((gradmagntools - thresholds(i)) > 0);
    title(['threshold:' num2str(thresholds(i))]);
end

gradmagntools = sqrt(Lv(godthem256, 'valid', 'sobel', false));
figure();
subplot(2, (length(thresholds)+1)/2, 1);
showgrey(gradmagntools);
title('Without thresholding');
for i=1:length(thresholds)
    subplot(2, (length(thresholds)+1)/2, 1+i);
    showgrey((gradmagntools - thresholds(i)) > 0);
    title(['threshold:' num2str(thresholds(i))]);
end

gradmagntools = sqrt(Lv(godthem256, 'valid', 'sobel', true));
figure();
subplot(2, (length(thresholds)+1)/2, 1);
showgrey(gradmagntools);
title('Without thresholding');
for i=1:length(thresholds)
    subplot(2, (length(thresholds)+1)/2, 1+i);
    showgrey((gradmagntools - thresholds(i)) > 0);
    title(['threshold:' num2str(thresholds(i))]);
end


