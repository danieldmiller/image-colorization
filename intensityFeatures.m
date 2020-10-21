
A = imread('flower.png');
A = rgb2gray(A);
fh = figure();
imshow(A);


[L,N] = superpixels(A,40);
BW = boundarymask(L);
% Get the average intensity values of all pixels within superpixel S
average_intensity1 = regionprops(L,A,'MeanIntensity');

% Change struct into an array of double
average_intensity1 = struct2cell(average_intensity1);
average_intensity1= cell2mat(average_intensity1);

arraySize = size(average_intensity1,2);
average_intensity2 = zeros(1,arraySize);

% Get the neighboring average intensity values of the neighboring superpixels of Si
for i =1:arraySize
    if(i==1)
        average_intensity2(1)=average_intensity1(i+1);
    elseif(i==arraySize)
        average_intensity2(arraySize)=average_intensity1(i-1);
    else
        average_intensity2(i)=1/2*(average_intensity1(i-1)+average_intensity1(i+1));
    end
end

        

