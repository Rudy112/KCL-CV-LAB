function[pos2]=ind_matches(I1,pos1,I2) 
%%step1:Detect interest points in images2.
%%Points1 are given and points2 are detected by KAZE feature detector.
%%According to lots of test, using KAZE feature detector to search interest
%%points in image 2 allways have better response than other detector.
points1 = pos1;
points2 = detectKAZEFeatures(rgb2gray(I2));

%%step2:Extract features around interest points.
%%Using the KAZE method to extract features in two images(obtain the same class of descriptor)
%%which makes the function robust to different points1 detected by
%%different methods.
%%During the experiment, the matches always perform better when setting Upright to 'true'
%%larger featuresize can make the feature extract more accurate
[f1, vpts1] = extractFeatures(rgb2gray(I1), points1,'method','KAZE','FeatureSize',128,'Upright',true);
[f2, vpts2] = extractFeatures(rgb2gray(I2), points2,'method','KAZE','FeatureSize',128,'Upright',true);

%%step3:Match interest points by features.
%%Using matchFeature to calculate the similarity of interest points in two images.
%%Seting the MaxRatio and MatchThreshold to maximum to obtain more possible matches.
%%but some outliers may not be deleted
[indexPairs,matchmetric] = matchFeatures(f1, f2,'MaxRatio',1,'MatchThreshold',100);
matchedPoints1 = vpts1(indexPairs(:, 1));
matchedPoints2 = vpts2(indexPairs(:, 2));
figure; showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
legend('matched points 1',' matched points 2');
pos2 = matchedPoints2
end



