function run_extractors()
% These scripts run all the extractors. Can be used for debugging
referenceI = imread('planes.jpg');
grayReferenceI = rgb2gray(referenceI);
targetI = rgb2gray(referenceI);

% intensity = intensityFeatures(I);
% std_dev = standard_deviation_features(I);
[gaborArrayRef,gaborMagRef] = gabor_features(grayReferenceI);
[gaborArrayTarget,gaborMagTarget] = gabor_features(targetI);
% surf = surf_feature(grayReferenceI, targetI);

indexes = gabor_matcher(referenceI, targetI, gaborMagRef, gaborMagTarget);
color_assignment = colorAssignment(referenceI, targetI, indexes);
color_assignment = double(color_assignment)/255

%Recuperation du nombre de canaux de couleurs
[H,W,n]=size(referenceI);

%Que pour interpolation.jpg
grayReferenceI = im2double(grayReferenceI);
grayReferenceI = cat(3, grayReferenceI, grayReferenceI, grayReferenceI);
markedI = imread("planes_marked.jpg");
markedI = im2double(markedI);
image_originale=grayReferenceI(H/8:H-H/8,W/8:W-W/8,:);
markedI = markedI(H/8:H-H/8,W/8:W-W/8,:);
colorized = preTraitement(image_originale,markedI);
figure, imshow(colorized);