function [matched_source,matched_dest] = surf_feature(s,d)
p1 = detectSURFFeatures(s).selectStrongest(128);
p2 = detectSURFFeatures(d).selectStrongest(128);
[fs,vs] = extractFeatures(s,p1);
[fd,vd] = extractFeatures(d,p2);
match_pairs = matchFeatures(fs,fd);
matched_source = vs(match_pairs(:,1));
matched_dest = vd(match_pairs(:,2));
%%Display
figure; 
showMatchedFeatures(s,d,matched_source,matched_dest);
legend('matched source','matched dest');

end