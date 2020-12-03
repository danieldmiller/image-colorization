function returnIndex = gabor_matcher(refI, targetI, refMag, targetMag, targetL, targetN, refL, refN)
%     returnIndex = zeros(targetN,targetN);
%     eps = 0.01;
%     
%     % Get the gabor feature value for each superpixel in target
%     idx = label2idx(targetL);
%     for labelVal = 1:targetN
%         valueIdx = idx{labelVal};
%         gaborVal = mean(targetMag(valueIdx));
%         
%         % Search reference image for match
%         idx1 = label2idx(refL);
%         minVal = mean(refMag(1));
%         index = [];
%         for labelVal2 = 2:refN
%             valueIdx1 = idx{labelVal2};
%             gaborVal1 = mean(refMag(valueIdx1));
%             
%             if abs(gaborVal1 - gaborVal) < eps
%                 minVal = gaborVal1;
%                 index = [index,labelVal2];
%             end
% 
%         end
% 
%         index = 1:size(index,2);
%         if size(index,2) < 1 || size(index,2) > size(returnIndex, 1)
%             continue
%         end
%         returnIndex(labelVal,1:size(index,2)) = index(1,:);
%     end
% end

    returnIndex = zeros(targetN, 1);
    
    % Get the gabor feature value for each superpixel in target
    idx = label2idx(targetL);
    for labelVal = 1:targetN
        valueIdx = idx{labelVal};
        gaborVal = mean(targetMag(valueIdx));
        
        % Search reference image for match
        idx1 = label2idx(refL);
        minVal = mean(refMag(1));
        index = 1;
        for labelVal2 = 2:refN
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