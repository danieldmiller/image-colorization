function intensity_feature = intensityFeatures(I)

% Test
% -------
% I = imread('dest1.jpg');
% I = rgb2gray(I);
% fh = figure();
% imshow(A);
% ------

% Change to [L,N] = I where I is the superpixels
[L,N] = superpixels(I,500);
% (1) Get the average intensity values of all pixels within superpixel S
average_intensity1 = regionprops(L,I,'MeanIntensity');

% Change struct into an array of double
average_intensity1 = struct2cell(average_intensity1);
average_intensity1= cell2mat(average_intensity1);

arraySize = size(average_intensity1,2);

% (2) Get the neighboring average intensity values of the neighboring superpixels of Si
average_intensity2 = zeros(1,arraySize);
for i =1:arraySize
    if(i==1)
        average_intensity2(1) = average_intensity1(i+1);
    elseif(i==arraySize)
        average_intensity2(arraySize) = average_intensity1(i-1);
    else
        average_intensity2(i)= 1/2 * (average_intensity1(i-1) + average_intensity1(i+1));
    end
end

% Store (1) and (2) in intensity_feature array of 2 rows 
intensity_feature = zeros(2,arraySize);
for i =1:arraySize
%     First row refers to (1)
    intensity_feature(1,i)=average_intensity1(i);
%     Second row refers to (2)
    intensity_feature(2,i)=average_intensity2(i);
end

%% Row 1 Overlay
outputImage = zeros(size(I),'like',I);
idx = label2idx(L);
for labelVal = 1:N
    intensity_idx = idx{labelVal};
    outputImage(intensity_idx) = average_intensity1(labelVal);
end    

figure
imshow(outputImage,'InitialMagnification',67)

%% Row 2 Overlay
outputImage = zeros(size(I),'like',I);
idx = label2idx(L);
for labelVal = 1:N
    intensity_idx = idx{labelVal};
    outputImage(intensity_idx) = average_intensity2(labelVal);
end    

figure
imshow(outputImage,'InitialMagnification',67)    

