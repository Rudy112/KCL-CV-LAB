Ia = imread('rooster.jpg');
Ib = imread('boxes.pgm');
Iag = rgb2gray(Ia);
Iad = im2double(Iag);
Ibd = im2double(Ib);
Ie = imread('elephant.png');
Ied = im2double(Ie);
h1 = fspecial('average',5);
h2 = fspecial('average',25);
con_a1 = conv2(Iad,h1,'same');
con_a2 = conv2(Iad,h2,'same');
con_b1 = conv2(Ibd,h1,'same');
con_b2 = conv2(Ibd,h2,'same');
figure(1)
subplot(2,2,1), imagesc(con_a1);colorbar
subplot(2,2,2), imagesc(con_a2);colorbar
subplot(2,2,3), imagesc(con_b1);colorbar
subplot(2,2,4), imagesc(con_b2);colorbar 
colormap('gray');
print -dpng 3_1_1.png


gau_1 = fspecial('gaussian',30,1.5);
gau_2 = fspecial('gaussian',60,10);
con_a3 = conv2(Iad,gau_1,'same');
con_a4 = conv2(Iad,gau_2,'same');
con_b3 = conv2(Ibd,gau_1,'same');
con_b4 = conv2(Ibd,gau_2,'same');
figure(2)
subplot(2,2,1), imagesc(con_a3);colorbar;
subplot(2,2,2), imagesc(con_a4);colorbar;
subplot(2,2,3), imagesc(con_b3);colorbar;
subplot(2,2,4), imagesc(con_b4);colorbar;
colormap('gray');
print -dpng 3_1_2.png

gau_3 = fspecial('gaussian',[1,60],10);
gau_4 = conv2(gau_3,transpose(gau_3),'full');
tic 
con_a5 = conv2(Iag,gau_3,'same');
con_a6 = conv2(con_a5,transpose(gau_3),'same');
toc
tic
con_a7 = conv2(Iag,gau_4,'same');
toc

figure(3)
y=sin([0:0.01:2*pi]); subplot(3,1,1), plot(y);
yd1=conv2(y,[-1,1],'valid'); subplot(3,1,2), plot(yd1)
yd2=conv2(y,[-1,2,-1],'valid'); subplot(3,1,3), plot(yd2)
print -dpng 4_1.png

Lap_1 = [-0.125,-0.125,-0.125;-0.125,1,-0.125;-0.125,-0.125,-0.125];
Lap_2 = [-1,-1,-1;-1,8,-1;-1,-1,-1];
con_b5 = conv2(Ibd,Lap_1,'same');
con_b6 = conv2(Ibd,Lap_2,'same');
figure(5)
subplot(1,2,1),imagesc(con_b5);colorbar;
subplot(1,2,2),imagesc(con_b6);colorbar;
colormap('gray')
print -dpng 4_2.png


sob = fspecial('sobel');
sob_t = transpose(sob);
pre = fspecial('prewitt');
pre_t = transpose(pre);
con_b7 = conv2(Ibd,sob,'same');
con_b8 = conv2(Ibd,sob_t,'same');
con_b9 = conv2(Ibd,pre,'same');
con_b10 = conv2(Ibd,pre_t,'same');
figure(6)
subplot(2,2,1),imagesc(con_b7);colorbar
subplot(2,2,2),imagesc(con_b8);colorbar
subplot(2,2,3),imagesc(con_b9);colorbar
subplot(2,2,4),imagesc(con_b10);colorbar
colormap('jet')








