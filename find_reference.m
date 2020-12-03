function a = find_reference(r,f,alpha)
%% Init weights
w = [0.2, 0.5, 0.2, 0.1];

%% get distance between r and t for each f
val = [];
for i = 1:alpha
    d = sqrt(r^2 + f(1,i)^2);
    d = w(1,1)*d;
    val = [val,d];
end

% for i = 1:alpha
%     F = 0;
%     for j = 1:4
%         F = F + w(1,j)*f(1,i)
%     end
%     val = [val; F];
% end

[b,a] = min(val);
a = f(1,a);
end