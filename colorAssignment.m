function color_assignment = colorAssignment(referenceI, targetI, indexes)
    [L,N] = superpixels(targetI,500);
    [L1,N1] = superpixels(referenceI,500);
    
    color_assignment = zeros(size(targetI,1), size(targetI,2), 3);
    
%     % Get the gabor feature value for each superpixel in target
%     idx = label2idx(L);
%     for labelVal = 1:N
%         valueIdx = idx{labelVal};
%         targetI(, 1) = mean(referenceI(indexes(labelVal), 1));
%     end

%       idx = label2idx(L);
%       idxRef = label2idx(L1);
% 
%       for i=1:size(indexes, 1)
%           valueIdx = idxRef{indexes(i, 1)};
%           imshow(referenceI(valueIdx));
%           test = [];
%           
% %           color_assignment(:,:,1) = mean(referenceI(valueIdx), 1);
% %           color_assignment(:,:,2) = mean(referenceI(valueIdx), 2);
% %           color_assignment(:,:,3) = mean(referenceI(valueIdx), 3);
%       end
     for i = 1:size(indexes,1)
         cur_sup = indexes(i,1);
         temp = rgb2gray(referenceI);
         mask = [L == cur_sup]; %% DEBUG
         
     end
     
end