function pixel = cascade_gabor(g_s, g_d, x,y)
%CASCADE_GABOR Summary of this function goes here
%   Performs Cascade mathcing for gabor features

%Compute distance between g_s and g_d
n = 40;
pixel = 1;
eps = 100;
for i = 1:n
    dist = sqrt((g_s(x,y,i) + g_d(x,y,i)).^2);
    if(dist > eps)
        pixel = 0;
    end
end
end

