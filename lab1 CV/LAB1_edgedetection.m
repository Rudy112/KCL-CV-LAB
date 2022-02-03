% gau_5 = fspecial('gaussian',30,5);           %5.1.1
% der_1 = [-1,1];
% der_2 = transpose(der_1);
% con_g1 = conv2(gau_5,der_1);                     
% con_g2 = conv2(gau_5,der_2);
% figure(1)
% subplot(2,2,1); mesh(con_g1);colorbar
% subplot(2,2,2); mesh(con_g2);colorbar
% con_b10x = conv2(Ibd,con_g1);
% con_b10y = conv2(Ibd,con_g2);
% subplot(2,2,3); imagesc(con_b10x);colorbar
% subplot(2,2,4); imagesc(con_b10y);colorbar
% colormap('jet');
% a = max(con_b10x,[],'all');
% a2 = min(con_b10x,[],'all');
% b = max(con_b10y,[],'all');
% b2 = min(con_b10y,[],'all');
% print -dpng 5_1_1.png
% match()
% 
% gau_6 = fspecial('gaussian',35,1.5);   %5.1.2
% con_g3 = conv2(gau_6,der_1);
% con_g4 = conv2(gau_6,der_2);
% con_b11x = conv2(Ibd,con_g3,'same');
% con_b11y = conv2(Ibd,con_g4,'same');
% a1 = max(con_b11x,[],'all');
% a1z = min(con_b11x,[],'all');
% b1 = max(con_b11y,[],'all');
% b1z = min(con_b11y,[],'all');
% figure(2)
% subplot(2,2,1); mesh(con_g3);colorbar
% subplot(2,2,2); mesh(con_g4);colorbar
% subplot(2,2,3); imagesc(con_b11x);colorbar
% subplot(2,2,4); imagesc(con_b11y);colorbar
% colormap('jet')
% print -dpng 5_1_2.png
% 
% con_b11 = sqrt(con_b11x.^2 + con_b11y.^2);         %5.1.3
% con_a8x = conv2(Iad,con_g3,'same');
% con_a8y = conv2(Iad,con_g4,'same');
% con_a8 = sqrt(con_a8x.^2 + con_a8y.^2);
% figure(3)
% subplot(1,2,1); imagesc(con_b11);colorbar
% subplot(1,2,2); imagesc(con_a8);colorbar
% colormap('gray')
% print -dpng 5_1_3.png
% 
% %5.2.1
% LoG1 = conv2(gau_6,Lap_1,'valid');      %standard derivation 1.5
% con_b12 = conv2(Ibd,LoG1);
% LoG2 = conv2(gau_5,Lap_1,'valid');       % standard derivation 5
% con_b13 = conv2(Ibd,LoG2);
% a5_2_11 = max(con_b12,[],'all');
% a5_2_12 = min(con_b12,[],'all');
% a5_2_21 = max(con_b13,[],'all');
% a5_2_22 = min(con_b13,[],'all');
% figure(4)
% subplot(2,2,1); mesh(LoG1);colorbar
% subplot(2,2,3); imagesc(con_b12);colorbar
% subplot(2,2,2); mesh(LoG2);colorbar
% subplot(2,2,4); imagesc(con_b13);colorbar
% colormap('jet')
% print -dpng 5_2_1.png
% 
% 
% 
% %5.2.2
% 
% con_a9 = conv2(Iad,LoG1);
% con_a10 = conv2(Iad,LoG2);
% figure(5)
% subplot(1,2,1); imagesc(con_a9);colorbar
% subplot(1,2,2); imagesc(con_a10);colorbar
% colormap('gray')
% print -dpng 5_2_2.png

%%%5.3 unfinished!!!!!!
gab1 = gabor2(4,8,90,0.5,0);
con_e1 = conv2(a1,gab1,'valid');
gab2 = gabor2(4,8,90,0.5,90);
con_e2 = conv2(a1,gab2,'valid');
con_e3 = sqrt(con_e1.^2+con_e2.^2);
figure(6)
subplot(2,2,1);imagesc(con_e1);colorbar;
subplot(2,2,2);imagesc(con_e3);colorbar;
colormap('gray')
I = [0,15,30,45,60,75,90,105,120,135,150,165];
for n = 1:12
    gabo = gabor2(4,8,I(n),0.5,0);
    con_e4 = conv2(a1,gabo,'valid');
    gabo_1(:,:,n) = con_e4;
    n = n + 1;
    
end
con_e5 = max(gabo_1,[],3);
subplot(2,2,3);imagesc(con_e5);colorbar;
print -dpng 5_3_1.png



function gb=gabor2(sigma,wavel,orient,aspect,phase)
%function gb=gabor(sigma,wavel,orient,aspect,phase)
%
% This function produces a numerical approximation to 2D Gabor function.
% Parameters:
% sigma  = standard deviation of Gaussian envelope, this in-turn controls the
%          size of the result (pixels)
% wavel  = the wavelength of the sin wave (pixels)
% orient = orientation of the Gabor from the vertical (degrees)
% aspect = aspect ratio of Gaussian envelope (0 = no modulation over "width" of
%          sin wave, 1 = circular symmetric envelope)
% phase  = the phase of the sin wave (degrees)

sz=fix(7*sigma./max(0.2,aspect));
if mod(sz,2)==0, sz=sz+1;end
 
[x y]=meshgrid(-fix(sz/2):fix(sz/2),fix(-sz/2):fix(sz/2));
 
% Rotation 
orient=orient*pi/180;
x_theta=x*cos(orient)+y*sin(orient);
y_theta=-x*sin(orient)+y*cos(orient);

phase=phase*pi/180;

gb=exp(-.5*((x_theta.^2/sigma^2)+(aspect^2*y_theta.^2/sigma^2))).*(cos(2*pi*(1./wavel)*x_theta+phase));

end





