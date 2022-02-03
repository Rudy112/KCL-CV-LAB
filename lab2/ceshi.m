I1 = im2double(imread('semper1.jpg'));
I2 = im2double(imread('semper2.jpg'));
detector = detectHarrisFeatures(rgb2gray(I1));
pos11 = selectStrongest(detector,25);
pos1 = pos11.Location;
[pos2] = find_matches(I1,pos1,I2);

