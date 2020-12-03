function run_extractors()
% % These scripts run all the extractors. Can be used for debugging
% referenceI = imread('flower_copy.png');
% grayReferenceI = rgb2gray(referenceI);
% targetI = rgb2gray(imread("flower.png"));
% % grayTargetI = rgb2gray(targetI);
% 
% % intensity = intensityFeatures(I);
% % std_dev = standard_deviation_features(I);
% [gaborArrayRef,gaborMagRef] = gabor_features(grayReferenceI);
% [gaborArrayTarget,gaborMagTarget] = gabor_features(targetI);
% % surf = surf_feature(grayReferenceI, targetI);
% 
% [targetL,targetN] = superpixels(targetI,1000);
% [refL,refN] = superpixels(referenceI,1000);
% 
% indexes = gabor_matcher(referenceI, targetI, gaborMagRef, gaborMagTarget, targetL, targetN, refL, refN);
% color_assignment = colorAssignment(referenceI, targetI, indexes, targetL, targetN, refL, refN);
% color_assignment = double(color_assignment)/255;
% 
% %Recuperation du nombre de canaux de couleurs
% [H,W,n]=size(targetI);
% 
% %Que pour interpolation.jpg
% % grayReferenceI = im2double(grayReferenceI);
% % grayReferenceI = cat(3, grayReferenceI, grayReferenceI, grayReferenceI);
% markedI = color_assignment;
% 
% 
% image_originale=targetI(H/8:H-H/8,W/8:W-W/8,:);
% image_originale = cat(3, image_originale, image_originale, image_originale);
% markedI = markedI(H/8:H-H/8,W/8:W-W/8,:);
% colorized = preTraitement(image_originale,markedI);
% figure, imshow(colorized);

    
    referenceI = imread('flower_copy.png');
    grayReferenceI = rgb2gray(referenceI);
    targetI = rgb2gray(imread("flower.png"));

    [targetL,targetN] = superpixels(targetI,1000);
    [refL,refN] = superpixels(referenceI,1000);
    
    [gaborArrayRef,gaborMagRef] = gabor_features(grayReferenceI);
    [gaborArrayTarget,gaborMagTarget] = gabor_features(targetI);
    % surf = surf_feature(grayReferenceI, targetI);
    %% get surf features

    s_points = detectSURFFeatures(grayReferenceI);
    d_points = detectSURFFeatures(targetI);

    indexes = gabor_matcher(referenceI, targetI, gaborMagRef, gaborMagTarget, targetL, targetN, refL, refN);
    % indexes_surf = gabor_matcher(referenceI, targetI, gaborMagRef, gaborMagTarget);

    i = [];
    for j = 1:size(indexes,1)
        temp = [indexes(j,:) > 0];
        a = indexes(j,temp);
        alpha = size(a,2);
        i = [i;find_reference(j,a,alpha)];
    end
%     color_assignment = colorAssignment(referenceI, targetI, i, targetL, targetN, refL, refN);
	 color_assignment = colorAssignment(referenceI, targetI, indexes, targetL, targetN, refL, refN);
    color_assignment = double(color_assignment)/255;
  
    % %Recuperation du nombre de canaux de couleurs
    [H,W,n]=size(targetI);

    % %Que pour interpolation.jpg
    grayReferenceI = im2double(grayReferenceI);
    grayReferenceI = cat(3, grayReferenceI, grayReferenceI, grayReferenceI);
    markedI = color_assignment;
    
  
    image_originale=targetI(H/8:H-H/8,W/8:W-W/8,:);
    image_originale = cat(3, image_originale, image_originale, image_originale);
    markedI = markedI(H/8:H-H/8,W/8:W-W/8,:);
    colorized = preTraitement(image_originale,markedI);
    figure, imshow(colorized);