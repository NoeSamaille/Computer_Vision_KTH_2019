% Part 1 - Difference operators - Question 1


% tools = few256;
% 
% dx_simple = [-1 1; 0 0];
% dy_simple = [-1 1; 0 0]';
% dx_centered = [0 0 0; -0.5 0 0.5; 0 0 0];
% dy_centered = [0 0 0;-0.5 0 0.5; 0 0 0]';
% Gx_roberts = [1 0; 0 -1];
% Gy_roberts = [0 1; -1 0];
% dx_sobel = [-1 0 1; -2 0 2; -1 0 1];
% dy_sobel = [-1 -2 -1; 0 0 0; 1 2 1];
% 
% dxtools_simple = conv2(tools, dx_simple, 'valid');
% dytools_simple = conv2(tools, dy_simple, 'valid');
% dxtools_centered = conv2(tools, dx_centered, 'valid');
% dytools_centered = conv2(tools, dy_centered, 'valid');
% Gxtools_roberts = conv2(tools, Gx_roberts, 'valid');
% Gytools_roberts = conv2(tools, Gy_roberts, 'valid');
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
% showgrey(Gxtools_roberts);
% title('Gxtools roberts');
% subplot(2, 4, 7);
% showgrey(Gytools_roberts);
% title('Gytools roberts');
% subplot(2, 4, 4);
% showgrey(dxtools_sobel);
% title('dxtools sobel');
% subplot(2, 4, 8);
% showgrey(dytools_sobel);
% title('dytools sobel');


% Part 2 - Point–wise thresholding of gradient magnitudes - Questions 2 & 3


% gradmagntools = sqrt(Lv(few256, 'valid', 'centered'));
% thresholds = [10 15 20 25];
% 
% figure();
% subplot(1, 3, 1);
% histogram(gradmagntools);
% title('Hist');
% for i=1:length(thresholds)
%     subplot(1, length(thresholds)+2, 2+i);
%     showgrey((gradmagntools - thresholds(i)) > 0);
%     title(['threshold:' num2str(thresholds(i))]);
% end
% 
% thresholds = [10 15 20 25 30];
% hem = sqrt(Lv(godthem256, 'valid', 'centered'));
% smoothed_hem = sqrt(Lv(gaussfft(godthem256, 1.0), 'valid', 'centered'));
% figure();
% subplot(2, length(thresholds)+1, 1);
% showgrey(hem);
% title('No threshold');
% for i=1:length(thresholds)
%     subplot(2, length(thresholds)+1, 1+i);
%     showgrey((hem - thresholds(i)) > 0);
%     title(['threshold:' num2str(thresholds(i))]);
% end
% subplot(2, length(thresholds)+1, length(thresholds)+2);
% showgrey(smoothed_hem);
% title('Smoothed, No threshold');
% for i=1:length(thresholds)
%     subplot(2, length(thresholds)+1, length(thresholds)+2+i);
%     showgrey((smoothed_hem - thresholds(i)) > 0);
%     title(['Smoothed, threshold:' num2str(thresholds(i))]);
% end


% Part 4 - Computing differential geometry descriptors - Questions 4 to 6


% % Test of the masks
% dx_mask = [0 0 0 0 0; 0 0 0 0 0; 0 -0.5 0 0.5 0; 0 0 0 0 0; 0 0 0 0 0];
% dy_mask = dx_mask';
% dxx_mask = [0 0 0 0 0; 0 0 0 0 0; 0 1 -2 1 0; 0 0 0 0 0; 0 0 0 0 0];
% dyy_mask = dxx_mask';
% dxxx_mask = conv2(dx_mask, dxx_mask, 'same');
% dxxy_mask = conv2(dxx_mask, dy_mask, 'same');
% dxyy_mask = conv2(dx_mask, dyy_mask, 'same');
% dyyy_mask = conv2(dy_mask, dyy_mask, 'same');
% [x y] = meshgrid(-5:5, -5:5)
% filter2(dxxx_mask, x.^3, 'valid')
% filter2(dxxx_mask, x.^2, 'valid')
% filter2(dxx_mask, x.^3, 'valid')
% filter2(dxxy_mask, x.^2.*y, 'valid')

% Question 4

% house = godthem256;
% scales = [0.0001 1.0 4.0 16.0 32.0 64.0];
% 
% figure();
% for i=1:length(scales)
%     subplot(2, length(scales)/2, i);
%     contour(Lvvtilde(discgaussfft(house, scales(i)), 'same'), [0 0])
%     axis('image') 
%     axis('ij')
%     title(['t:' num2str(scales(i))]);
% end
% 
% tools = few256;
% scales = [0.0001 1.0 4.0 16.0 32.0 64.0];
% 
% figure();
% for i=1:length(scales)
%     subplot(2, length(scales)/2, i);
%     showgrey(Lvvvtilde(discgaussfft(tools, scales(i)), 'same') < 0)
%     title(['t:' num2str(scales(i))]);
% end

% Question 5

% house = godthem256;
% scales = [1.0 4.0 16.0 32.0];
% figure();
% for i=1:length(scales)
%     subplot(2, length(scales), i);
%     contour(Lvvtilde(discgaussfft(house, scales(i)), 'same'), [0 0])
%     axis('image') 
%     axis('ij')
%     title(['L_v = 0, t:' num2str(scales(i))]);
%     subplot(2, length(scales), length(scales)+i);
%     showgrey(Lvvvtilde(discgaussfft(house, scales(i)), 'same') < 0)
%     title(['L_{vv} < 0, t:' num2str(scales(i))]);
% end


% Part 5 - Extraction of edge segments - Question 7


% % Chose best scale for 'tools' image
% scales = [1.0 2.0 4.0 6.0 8.0 10.0 12.0 16.0];
% figure();
% for i=1:length(scales)
%     subplot(2, length(scales)/2, i);
%     extractedge(few256, scales(i), 1, 'same');
%     title(['t:' num2str(scales(i))]);
% end
% 
% % Chose best threshold for 'tools' image
% thresholds = [1 5 10 15 20 26 30 40 50 60];
% figure();
% for i=1:length(thresholds)
%     subplot(2, length(thresholds)/2, i);
%     extractedge(few256, 8.0, thresholds(i), 'same');
%     title(['threshold:' num2str(thresholds(i))]);
% end
% 
% % Chose best scale for 'home' image
% scales = [1.0 2.0 4.0 6.0 8.0 16.0];
% figure();
% for i=1:length(scales)
%     subplot(2, length(scales)/2, i);
%     extractedge(godthem256, scales(i), 1, 'same');
%     title(['t:' num2str(scales(i))]);
% end
% 
% Chose best threshold for 'home' image
% thresholds = [1 5 7 10 15 20];
% figure();
% for i=1:length(thresholds)
%     subplot(2, length(thresholds)/2, i);
%     extractedge(godthem256, 4.0, thresholds(i), 'same');
%     title(['threshold:' num2str(thresholds(i))]);
% end
% 
% Show best results
% figure();
% subplot(1, 2, 1);
% extractedge(few256, 8.0, 26, 'same');
% title('Tools: t=8, threshold=26');
% subplot(1, 2, 2);
% extractedge(godthem256, 4.0, 7, 'same');
% title('Home: t=4, threshold=7');


% Part 6 - Hough transform - Questions 8 to 10


% % Question 8
% testimage1 = triangle128;
% nrho = 200;
% ntheta = 181;
% houghedgeline(testimage1, 6, 1, nrho, ntheta, 3, 2);

% % Question 9, set accumulator update to 1 in houghline
% nrho = 400;
% ntheta = 181;
% houghedgeline(houghtest256, 3, 10, nrho, ntheta, 9, 1);
% houghedgeline(few256, 8, 8, nrho, ntheta, 12, 1);
% houghedgeline(phonecalc256, 3, 18, nrho, ntheta, 13, 1);
% houghedgeline(godthem256, 5, 15, nrho, ntheta, 19, 1);

% % Question 10, set accumulator update to linear or log in houghline
% nrho = 400;
% ntheta = 181;
% houghedgeline(houghtest256, 2, 10, nrho, ntheta, 9, 1);
% houghedgeline(few256, 5, 8, nrho, ntheta, 12, 1);
% houghedgeline(phonecalc256, 3, 18, nrho, ntheta, 13, 1);
% houghedgeline(godthem256, 4, 15, nrho, ntheta, 19, 1);
