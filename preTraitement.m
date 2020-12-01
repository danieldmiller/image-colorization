function [nI]=preTraitement(gI,cI)



I_NDG=gI;
I_Marked=cI; % Normalization image marquée
I_Traces=(sum(abs(I_NDG-I_Marked),3)>0.2);  % S'il y a une différence minime de 
% la valeur d'un pixel c'est que celui ci a été marqué;
% On récupère ainsi tous les pixels marqués, en blanc sur fond noir.
I_Traces=double(I_Traces); % On passe de logical-> double

 % On change d'espace colorimétrique, on passe de RGB à YIQ
 % Y: luminance relative
 % I: composante en phase
 % Q: chorminance
 % En gros, Y=luminosité; I,Q=couleur
I_NDG_YIQ=rgb2ntsc(I_NDG); % Dimension=HxLx3
I_Marked_YIQ=rgb2ntsc(I_Marked);
   
I_Final_YIQ(:,:,1)=I_NDG_YIQ(:,:,1); % On récupère la luminance de l'image en NDG
I_Final_YIQ(:,:,2)=I_Marked_YIQ(:,:,2); % Interpolation et quadrature des marqueurs
I_Final_YIQ(:,:,3)=I_Marked_YIQ(:,:,3);

% On redimensionne
max_d=floor(log(min(size(I_Final_YIQ,1),size(I_Final_YIQ,2)))/log(2)-2);
iu=floor(size(I_Final_YIQ,1)/(2^(max_d-1)))*(2^(max_d-1)); % En hauteur
ju=floor(size(I_Final_YIQ,2)/(2^(max_d-1)))*(2^(max_d-1)); % En largeur
id=1; jd=1;
I_Traces=I_Traces(id:iu,jd:ju,:);
I_Final_YIQ=I_Final_YIQ(id:iu,jd:ju,:);


nI=optimisation(I_Traces,I_Final_YIQ);


end
   
  
