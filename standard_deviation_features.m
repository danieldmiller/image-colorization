function std_deviation_feature = standard_deviation_features(I)

% Test
% -------
I = imread('dest1.jpg');
I = rgb2gray(I);
% fh = figure();
% imshow(I);
% ------

[L,N] = superpixels(I,1000);

% (1) Get the average standard deviation value of each pixel using 5x5
% window
idx = label2idx(L);
standard_deviation1 = zeros(1, N);
for labelVal = 1:N
    valueIdx = idx{labelVal};
    standard_deviation1(labelVal) = mean(stdfilt(I(valueIdx), true(5)));
end

arraySize = size(standard_deviation1, 2);

% (2) Get the neighboring average standard deviation values of the
% neighboring superpixels of Si
standard_deviation2 = zeros(1,arraySize);
for i = 1:arraySize
    if(i==1)
        standard_deviation2(1) = standard_deviation1(i+1);
    elseif(i==2)
        standard_deviation2(2) = 1/2 * (standard_deviation1(i+1) + standard_deviation1(i-1));
    elseif(i==arraySize)
        standard_deviation2(arraySize) = standard_deviation1(i-1);
    elseif(i==arraySize - 1)
        standard_deviation2(arraySize) = 1/2 * (standard_deviation1(i-1) + standard_deviation1(i-2));
    else
        standard_deviation2(i) = 1/4 * (standard_deviation1(i-2) + standard_deviation1(i-1) + standard_deviation1(i+1) + standard_deviation1(i+2));
    end
end

% Store (1) and (2) in std_deviation_feature array of 2 rows 
std_deviation_feature = zeros(2, arraySize);
for i =1:arraySize
    % First row refers to (1)
    std_deviation_feature(1,i) = standard_deviation1(i);
    % Second row refers to (2)
    std_deviation_feature(2,i) = standard_deviation2(i);
end

%% Row 1 Overlay
outputImage = zeros(size(I),'like',I);
idx = label2idx(L);
for labelVal = 1:N
    std_dev_idx = idx{labelVal};
    outputImage(std_dev_idx) = standard_deviation1(labelVal);
end    

figure
imshow(outputImage,'InitialMagnification',67)

%% Row 2 Overlay
outputImage = zeros(size(I),'like',I);
idx = label2idx(L);
for labelVal = 1:N
    std_dev_idx = idx{labelVal};
    outputImage(std_dev_idx) = standard_deviation2(labelVal);
end    

figure
imshow(outputImage,'InitialMagnification',67)    