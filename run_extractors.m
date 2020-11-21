function run_extractors()
% These scripts run all the extractors. Can be used for debugging
referenceI = imread('flower.png');
grayReferenceI = rgb2gray(referenceI);
targetI = rgb2gray(referenceI);

% intensity = intensityFeatures(I);
% std_dev = standard_deviation_features(I);
[gaborArrayRef,gaborMagRef] = gabor_features(grayReferenceI);
[gaborArrayTarget,gaborMagTarget] = gabor_features(targetI);
% surf = surf_feature(grayReferenceI, targetI);

indexes = gabor_matcher(referenceI, targetI, gaborMagRef, gaborMagTarget);
color_assignment = colorAssignment(referenceI, targetI, indexes);
% Assign colors by searching for similar gabor features for each superpixel
% for i = 1 : length(gaborArrayTarget)
%     disp(gaborArrayTarget(i));
% end


