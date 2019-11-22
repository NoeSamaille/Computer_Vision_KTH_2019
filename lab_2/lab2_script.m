% Part 1 - Difference operators - Question 1

% 
% tools = few256;
% 
% dx_simple = [-1 1; 0 0];
% dy_simple = [-1 1; 0 0]';
% dx_centered = [0 0 0; -0.5 0 0.5; 0 0 0];
% dy_centered = [0 0 0;-0.5 0 0.5; 0 0 0]';
% dx_roberts = [1 0; 0 -1];
% dy_roberts = [0 1; -1 0];
% dx_sobel = [-1 0 1; -2 0 2; -1 0 1];
% dy_sobel = [-1 -2 -1; 0 0 0; 1 2 1];
% 
% dxtools_simple = conv2(tools, dx_simple, 'valid');
% dytools_simple = conv2(tools, dy_simple, 'valid');
% dxtools_centered = conv2(tools, dx_centered, 'valid');
% dytools_centered = conv2(tools, dy_centered, 'valid');
% dxtools_roberts = conv2(tools, dx_roberts, 'valid');
% dytools_roberts = conv2(tools, dy_roberts, 'valid');
% dxtools_sobel = conv2(tools, dx_sobel, 'valid');
% dytools_sobel = conv2(tools, dy_sobel, 'valid');
% 
% figure();
% subplot(2, 4, 1);
% showgrey(dxtools_simple);
% title('dxtools simple');
% subplot(2, 4, 5);
% showgrey(dytools_simple);
% title('dytools simple');
% subplot(2, 4, 2);
% showgrey(dxtools_centered);
% title('dxtools centered');
% subplot(2, 4, 6);
% showgrey(dytools_centered);
% title('dytools centered');
% subplot(2, 4, 3);
% showgrey(dxtools_roberts);
% title('dxtools roberts');
% subplot(2, 4, 7);
% showgrey(dytools_roberts);
% title('dytools roberts');
% subplot(2, 4, 4);
% showgrey(dxtools_sobel);
% title('dxtools sobel');
% subplot(2, 4, 8);
% showgrey(dytools_sobel);
% title('dytools sobel');


% Part 2 - Point–wise thresholding of gradient magnitudes - Questions 2 & 3


% gradmagntools = sqrt(Lv(tools, 'valid', 'centered', false));
% thresholds = [5 10 15 20 25 30 35];
% 
% figure();
% subplot(1, 1, 1);
% histogram(gradmagntools);
% title('hist');
% 
% figure();
% subplot(2, (length(thresholds)+1)/2, 1);
% showgrey(gradmagntools);
% title('Without thresholding');
% for i=1:length(thresholds)
%     subplot(2, (length(thresholds)+1)/2, 1+i);
%     showgrey((gradmagntools - thresholds(i)) > 0);
%     title(['threshold:' num2str(thresholds(i))]);
% end
% 
% gradmagntools = sqrt(Lv(tools, 'valid', 'centered', true));
% figure();
% subplot(2, (length(thresholds)+1)/2, 1);
% showgrey(gradmagntools);
% title('Without thresholding');
% for i=1:length(thresholds)
%     subplot(2, (length(thresholds)+1)/2, 1+i);
%     showgrey((gradmagntools - thresholds(i)) > 0);
%     title(['threshold:' num2str(thresholds(i))]);
% end
% 
% gradmagntools = sqrt(Lv(godthem256, 'valid', 'centered', true));
% figure();
% subplot(2, (length(thresholds)+1)/2, 1);
% showgrey(gradmagntools);
% title('Without thresholding');
% for i=1:length(thresholds)
%     subplot(2, (length(thresholds)+1)/2, 1+i);
%     showgrey((gradmagntools - thresholds(i)) > 0);
%     title(['threshold:' num2str(thresholds(i))]);
% end


% Part 4 - Computing differential geometry descriptors - Questions 4 to 6

% Test of third order masks
dx_mask = [0 0 0 0 0; 0 0 0 0 0; 0 -0.5 0 0.5 0; 0 0 0 0 0; 0 0 0 0 0];
dy_mask = dx_mask';
dxx_mask = [0 0 0 0 0; 0 0 0 0 0; 0 1 -2 1 0; 0 0 0 0 0; 0 0 0 0 0];
dyy_mask = dxx_mask';
dxxx_mask = conv2(dx_mask, dxx_mask, 'same');
dxxy_mask = conv2(dxx_mask, dy_mask, 'same');
dxyy_mask = conv2(dx_mask, dyy_mask, 'same');
dyyy_mask = conv2(dy_mask, dyy_mask, 'same');

[x y] = meshgrid(-5:5, -5:5)
filter2(dxxx_mask, x.^3, 'valid')
filter2(dxx_mask, x.^3, 'valid')
filter2(dxxy_mask, x.^2.*y, 'valid')

% Question 4
house = godthem256;
contour(Lvvtilde(discgaussfft(house, 16.0), 'same'), [0 0])
axis('image') 
axis('ij')


