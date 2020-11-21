function color_assignment = colorAssignment(referenceI, targetI, indexes)
    [L,N] = superpixels(targetI,1000);
    [L1,N1] = superpixels(referenceI,1000);
    
    color_assignment = zeros(size(targetI,1), size(targetI,2), 3);

    refR = referenceI(:,:,1);
    refG = referenceI(:,:,2);
    refB = referenceI(:,:,3);
    
    % Get the gabor feature value for each superpixel in target
    idx = label2idx(L1);
    idxTarget = label2idx(L);
    numRows = size(referenceI,1);
    numCols = size(referenceI,2);
    for labelVal = 1:N
        valueIdx = idx{indexes(labelVal, 1)};
        redMean = mean(refR(valueIdx));
        greenMean = mean(refG(valueIdx));
        blueMean = mean(refB(valueIdx));

        redIdx = idxTarget{labelVal};
        greenIdx = idxTarget{labelVal}+numRows*numCols;
        blueIdx = idxTarget{labelVal}+2*numRows*numCols;

        color_assignment(redIdx) = redMean;
        color_assignment(greenIdx) = greenMean;
        color_assignment(blueIdx) = blueMean;
    end

    rgbTarget = cat(3, targetI, targetI, targetI);
    alpha = 0.4;
    C = alpha * uint8(rgbTarget) + (1 - alpha) * uint8(color_assignment);
    figure, imshow(C);
    figure, imshow(uint8(color_assignment));
end