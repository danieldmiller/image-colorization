function [gaborArray,gaborMag] = gabor_features(I)
    end_t = 7*pi/8;
    orientation = 0:pi/8:end_t;
    scale = [5,10,15,20,25];
    gaborArray = gabor(scale,orientation);
    gaborMag = imgaborfilt(I,gaborArray);

    % figure
    % subplot(5,8,1);
    % for p = 1:40
    %     subplot(5,8,p)
    %     imshow(gaborMag(:,:,p),[]);
    % end
end