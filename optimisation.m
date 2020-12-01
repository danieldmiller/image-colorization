function [nI]=optimisation(I_Traces,I_Final_YIQ)
% I_Final_YIQ est une image en YIQ qui a la luminance de l'image originale
% en NDG, et les composantes de "couleur" de l'image avec les scribbles

% Premier paramÀtre est le r»sultat voulu
H=size(I_Final_YIQ,1); % Hauteur
W=size(I_Final_YIQ,2); % Largeur
nbPixels=H*W; % Nombre de pixels


nI(:,:,1)=I_Final_YIQ(:,:,1); % Renommage

% Tous les chiffres de 1 au nb de pixels dans une matrice de taille HxW
% Chaque pixel connait sa position dans l'image gr?ce ? son ID
nums_pixels=reshape([1:nbPixels],H,W); 

indicesPixelsMarked=find(I_Traces); % Matrice des indices des pixels marqu»s

tailleFen=1; % La taille de la fenÕtre autour du pixel concern» ? laquelle on accÀde

len=0;
id_pix_centre_courant=0;
% Nombre de pixels dans une fenetre de rayon tailleFen autour d'un pixel 
% incluant ce dernier : (2*tailleFen+1)^2
% Nombre total de pixels balay»s : nbPixels*(2*tailleFen+1)^2 (SANS PRISE
% EN COMPTE DES BORDS)
ind_ligne=zeros(nbPixels*(2*tailleFen+1)^2,1); % Abscisses de tous les pixels parcourus
ind_colonne=zeros(nbPixels*(2*tailleFen+1)^2,1); % Ordonn»es de tous les pixels parcourus
J=zeros(nbPixels*(2*tailleFen+1)^2,1); % Valeur de chacun des pixels concern»s (COULEUR???)
luminance_pix_fenetre=zeros(1,(2*tailleFen+1)^2); % ???
poids=zeros(1,(2*tailleFen+1)^2);
% On parcourt tous les pixels dans l'image
for abs_pix_centre=1:W % Largeur
   for ord_pix_centre=1:H % Hauteur
      id_pix_centre_courant=id_pix_centre_courant+1; % Identifiant du pixel parcouru (ID)
      
      if (~I_Traces(ord_pix_centre,abs_pix_centre))   % Si le pixel d'indices (i,j) n'est pas color»
        ind_parcours_fen=0;
        % On parcourt chaque pixels de la fenÕtre autour du pixel concern»
        % min et max pour ne pas d»passer des bords de l'image
        % ii et jj sont des coordonn»es relative ? l'image de base cad 
        % 0<ii<=H et 0<jj<=W
        for ord_pix_fen=max(1,ord_pix_centre-tailleFen):min(ord_pix_centre+tailleFen,H) 
           for abs_pix_fen=max(1,abs_pix_centre-tailleFen):min(abs_pix_centre+tailleFen,W)
            
              if (ord_pix_fen~=ord_pix_centre)||(abs_pix_fen~=abs_pix_centre) % Pour tous les pixels sauf le pixel (i,j)
                 len=len+1; ind_parcours_fen=ind_parcours_fen+1;
                 
                 % On indique ? chaque pixel de la fenÕtre l'identifiant du
                 % pixel sur laquelle celle ci est centr»e
                 ind_colonne(len)= id_pix_centre_courant;
                 ind_ligne(len)=nums_pixels(ord_pix_fen,abs_pix_fen);
                 luminance_pix_fenetre(ind_parcours_fen)=I_Final_YIQ(ord_pix_fen,abs_pix_fen,1);
              end
           end
        end
        luminance_pix_centre=I_Final_YIQ(ord_pix_centre,abs_pix_centre,1);
        luminance_pix_fenetre(ind_parcours_fen+1)=luminance_pix_centre;
        % Calcul de la variance des intensit» dans la fenÕtre autour du
        % pixel V(X)=E[ ( X - E(X) )^2 ]
        variance=mean((luminance_pix_fenetre-mean(luminance_pix_fenetre)).^2);
        mgv=min((luminance_pix_fenetre(1:ind_parcours_fen)-luminance_pix_centre).^2);
        variance=0.6*variance;
        if (variance<0.000002) % On rend les diffÈrences visibles par Matlab
           variance=0.000002;
        end

        poids(1:ind_parcours_fen)=exp(-(luminance_pix_fenetre(1:ind_parcours_fen)-luminance_pix_centre).^2/(variance)); % Poids ( (2) dans l'article)
        
        % Fait en sorte que la fonction de poids somme ? 1
        poids(1:ind_parcours_fen)=poids(1:ind_parcours_fen)/sum(poids(1:ind_parcours_fen)); 
        J(len-ind_parcours_fen+1:len)=-poids(1:ind_parcours_fen);
        
      end % Fin du si le pixel n'est pas color»

        
      len=len+1;
      ind_colonne(len)= id_pix_centre_courant;
      ind_ligne(len)=nums_pixels(ord_pix_centre,abs_pix_centre);
      J(len)=1; 
        
   end
end % Fin du parcour de tous les pixels

% On r»duit les vecteurs ? la longueur qu'ils font r»ellement     
J=J(1:len);
ind_ligne=ind_ligne(1:len);
ind_colonne=ind_colonne(1:len);

% sparse(abscisses des valeurs, ordonn»es des valeurs, valeurs, largeur,
% hauteur)
% Cette commande cr»e une matrice de taille consts_len x nbPixels contenant
% aux coordonn»es (row_inds,col_inds) la valeur vals
% (3,1) 3 eme colonne 1 ere ligne
A=sparse(ind_colonne,ind_ligne,J,id_pix_centre_courant,nbPixels);
couleurPixelsMarked=zeros(size(A,1),1);
 

for t=2:3
    coulCompI_Final=I_Final_YIQ(:,:,t); % Valeur des pixels marqu»s, 0 ailleurs
    couleurPixelsMarked(indicesPixelsMarked)=coulCompI_Final(indicesPixelsMarked);
    new_vals=A\couleurPixelsMarked;   % Solution X de AX=B
    nI(:,:,t)=reshape(new_vals,H,W,1); % Met sous forme HxWx1 les valeurs
end


nI=ntsc2rgb(nI); % Format RGB
