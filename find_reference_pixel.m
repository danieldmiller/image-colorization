function a = find_reference_pixel(r,f,alpha)
%% Init weights
w = [0.2, 0.5, 0.2, 0.1];

%% get distance between r and t for each f
val = [];
for i = 1:alpha
    F = 0;
    for j = 1:4
        F = F + w(1,j)*f(i,j)
    end
    val = [val; F];
end

a = min(val);
end

