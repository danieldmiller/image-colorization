function color_assignment = colorAssignment(referenceI, targetI, indexes, targetL, targetN, refL, refN)
    color_assignment = cat(3, targetI, targetI, targetI);
    
    refR = referenceI(:,:,1);
    refG = referenceI(:,:,2);
    refB = referenceI(:,:,3);

    % Get the gabor feature value for each superpixel in target
    refIdx = label2idx(refL);
    targetIdx = label2idx(refL);
    numRows = size(referenceI,1);
    numCols = size(referenceI,2);
    
    % INDEXES
    % target superpixel => ref superpixel
    for labelVal = 1:refN
%         valueIdx = targetIdx{indexes(labelVal, 1)};
        valueIdx = targetIdx{labelVal};
        centerOfSuperPixel = median(valueIdx);

        midpoint = round(length(valueIdx)/2);
        centerValues = valueIdx(midpoint-15:midpoint+16);

        
        if labelVal > size(indexes, 1)
            continue
        end
        % Get r,g,b means from ref superpixel.
        correspondingRefSuperpixelNum = indexes(labelVal);
        refValueIdx = refIdx{correspondingRefSuperpixelNum};
        redMean = mean(refR(refValueIdx));
        greenMean = mean(refG(refValueIdx));
        blueMean = mean(refB(refValueIdx));

        redChannel = color_assignment(:,:,1);
        greenChannel = color_assignment(:,:,2);
        blueChannel = color_assignment(:,:,3);

        redChannel(centerValues) = redMean;
        greenChannel(centerValues) = greenMean;
        blueChannel(centerValues) = blueMean;
     
        
        new_color_assignment = cat(3, redChannel, greenChannel, blueChannel);
%         redIdx = idxTarget{labelVal};
%         greenIdx = idxTarget{labelVal}+numRows*numCols;
%         blueIdx = idxTarget{labelVal}+2*numRows*numCols;
        color_assignment = new_color_assignment;

%         color_assignment(redIdx) = redMean;
%         color_assignment(greenIdx) = greenMean;
%         color_assignment(blueIdx) = blueMean;
    end 
    
end