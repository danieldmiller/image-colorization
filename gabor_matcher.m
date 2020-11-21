function returnIndex = gabor_matcher(refI, targetI, refMag, targetMag)
    [L,N] = superpixels(targetI,500);
    [L1,N1] = superpixels(refI,500);

    returnIndex = zeros(N, 1);
    
    % Get the gabor feature value for each superpixel in target
    idx = label2idx(L);
    for labelVal = 1:N
        valueIdx = idx{labelVal};
        gaborVal = mean(targetMag(valueIdx));
        
        % Search reference image for match
        idx1 = label2idx(L1);
        minVal = mean(refMag(1));
        index = 1;
        for labelVal2 = 2:N1
            valueIdx1 = idx{labelVal2};
            gaborVal1 = mean(refMag(valueIdx1));
            if abs(gaborVal1 - gaborVal) < abs(minVal - gaborVal)
                minVal = gaborVal1;
                index = labelVal2;
            end
        end
        
        returnIndex(labelVal, 1) = index;
    end
end