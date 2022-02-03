%%6 7
%Ie = imread('elephant.png');
Iw = imread('woods.png');
Iwd = im2double(Iw);
%Iag = rgb2gray(Ia); 
%shi = zeros(61);
%shi1 = zeros(31);
%shi1(16,1) = 1;
%shi(31,1) = 1;
%Iw_shift = conv2(Iw,shi,'same');
%coe1 = corr2(Iw,Iw_shift);
%Iw_shift2 = conv2(Iw,shi1,'same');
%figure(10)
%subplot(1,3,1);imagesc(Iw_shift);
%subplot(1,3,2);imagesc(Iw)
%subplot(1,3,3);imagesc(Iw_shift2)
for n = 0:30
    con_woods = Iwd(1+n:170,1:170);
    con_woods1 = Iwd(1:170-n,1:170);
    con_rooster = Iad(1+n:341,1:386);
    con_rooster1 = Iad(1:341-n,1:386);
    coe1 = corr2(con_woods,con_woods1);
    coe2 = corr2(con_rooster,con_rooster1);
    coe(n+1) = coe1; 
    coe_(n+1) = coe2;
    n = n+1;
end
figure(1);
n = (0:1:30);
subplot(1,2,1);plot(n,coe(n+1));
subplot(1,2,2);plot(n,coe_(n+1));
print -dpng 6_1_1.png





redun_gau1 = fspecial('gaussian',36,6);
redun_gau2 = fspecial('gaussian',36,2);
DoG1 = redun_gau2 - redun_gau1;
con_DoG11 = conv2(Iwd,DoG1,'same');
con_DoG12 = conv2(Iad,DoG1,'same');
redun_gau3 = fspecial('gaussian',36,4);
redun_gau4 = fspecial('gaussian',36,0.5);
DoG2 = redun_gau4 - redun_gau3;
con_DoG21 = conv2(Iwd,DoG2,'same');
con_DoG22 = conv2(Iad,DoG2,'same');
for n = 0:30
    con_woods = con_DoG11(1+n:170,1:170);
    con_woods1 = con_DoG11(1:170-n,1:170);
    con_rooster = con_DoG12(1+n:341,1:386);
    con_rooster1 = con_DoG12(1:341-n,1:386);
    coe1 = corr2(con_woods,con_woods1);
    coe2 = corr2(con_rooster,con_rooster1);
    coe_redun11(n+1) = coe1; 
    coe_redun12(n+1) = coe2;
    n = n+1;
end
figure(2);
n = (0:1:30);
subplot(2,2,1);plot(n,coe_redun11(n+1));
subplot(2,2,2);plot(n,coe_redun12(n+1));
for n = 0:30
    con_woods = con_DoG21(1+n:170,1:170);
    con_woods2 = con_DoG21(1:170-n,1:170);
    con_rooster = con_DoG22(1+n:341,1:386);
    con_rooster2 = con_DoG22(1:341-n,1:386);
    data_shift{n+1} = con_woods;
    data_shift1{n+1} = con_rooster;
    coe1 = corr2(con_woods,con_woods2);
    coe2 = corr2(con_rooster,con_rooster2);
    coe_redun21(n+1) = coe1; 
    coe_redun22(n+1) = coe2;
    n = n+1;
end
n = (0:1:30);
subplot(2,2,3);plot(n,coe_redun21(n+1));
subplot(2,2,4);plot(n,coe_redun22(n+1));
print -dpng 6_2_1.png



Iabb = im2double(Ia);
%%7color detection unfinished!!!!1
color_gau1 = fspecial('gaussian',25,2);
color_gau2 = fspecial('gaussian',25,3);
rg1 = conv2(Iabb(:,:,1),color_gau1,'same');
gg1 = conv2(Iabb(:,:,2),color_gau2,'same');
color_det1 = rg1 - gg1;
gg2 = conv2(Iabb(:,:,2),color_gau1,'same'); %green on red off
rg2 = conv2(Iabb(:,:,1),color_gau2,'same');
color_det2 = gg2 - rg2;
bg3 = conv2(Iabb(:,:,3),color_gau1,'same');
yg3 = conv2(mean(Iabb(:,:,1:2),3),color_gau2,'same');
color_det3 = bg3 - yg3;
yg4 = conv2(mean(Iabb(:,:,1:2),3),color_gau1,'same');
bg4 = conv2(Iabb(:,:,3),color_gau2,'same');
color_det4 = yg4 - bg4;
figure(3)
subplot(2,2,1); imagesc(color_det1);colorbar;
subplot(2,2,2); imagesc(color_det2);colorbar;
subplot(2,2,3); imagesc(color_det3);colorbar;
subplot(2,2,4); imagesc(color_det4);colorbar;
colormap('gray')
print -dpng 7_1_1.png


%%%%multi_scale representation
mul_gau = fspecial('gaussian',25,1);
Ia1 = imresize(conv2(Iad,mul_gau,'same'),0.5,'nearest');
Ia2 = imresize(conv2(Ia1,mul_gau,'same'),0.5,'nearest');
Ia3 = imresize(conv2(Ia2,mul_gau,'same'),0.5,'nearest');     %%%8.1
Ia4 = imresize(conv2(Ia3,mul_gau,'same'),0.5,'nearest');
figure(4);
subplot(2,2,1); imagesc(Ia1);colorbar;
subplot(2,2,2); imagesc(Ia2);colorbar;
subplot(2,2,3); imagesc(Ia3);colorbar;
subplot(2,2,4); imagesc(Ia4);colorbar;
colormap('gray');
print -dpng 8_1_1.png

Ia_lapla11 = Iad;
Ia_lapla12 = conv2(Ia_lapla11,mul_gau,'same');
Ia_lapla1 = Ia_lapla11 - Ia_lapla12;

Ia_lapla21 = imresize(Ia_lapla12,0.5,'nearest');
Ia_lapla22 = conv2(Ia_lapla21,mul_gau,'same');
Ia_lapla2 = Ia_lapla21 - Ia_lapla22;

Ia_lapla31 = imresize(Ia_lapla22,0.5,'nearest');
Ia_lapla32 = conv2(Ia_lapla31,mul_gau,'same');
Ia_lapla3 = Ia_lapla31 - Ia_lapla32;

Ia_lapla41 = imresize(Ia_lapla32,0.5,'nearest');
Ia_lapla42 = conv2(Ia_lapla41,mul_gau,'same');
Ia_lapla4 = Ia_lapla41 - Ia_lapla42;

Ia_lapla51 = imresize(Ia_lapla42,0.5,'nearest');
Ia_lapla52 = conv2(Ia_lapla51,mul_gau,'same');
Ia_lapla5 = Ia_lapla51 - Ia_lapla52;

figure(5);
subplot(2,2,1); imagesc(Ia_lapla2);colorbar;
subplot(2,2,2); imagesc(Ia_lapla3);colorbar;
subplot(2,2,3); imagesc(Ia_lapla4);colorbar;
subplot(2,2,4); imagesc(Ia_lapla5);colorbar;
colormap('gray')
print -dpng 8_2_1.png
    
    
   