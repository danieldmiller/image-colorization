function run_extractors()
% These scripts run all the extractors. Can be used for debugging
I = imread('flower.png');
I = rgb2gray(I);

intensity = intensityFeatures(I);
std_dev = standard_deviation_features(I);
[gaborArray,gaborMag] = gabor_features(I);
surf = surf_feature(I);
