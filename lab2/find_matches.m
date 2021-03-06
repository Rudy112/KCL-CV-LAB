%%student number :1924419


%%step1:Detect interest points in images2.
%%Points1 are given and points2 are detected by KAZE detector.
%%Using a reference match pair to do RANSAC and delect outliers
%%Reference points are deteced by BRISK detector
function[pos2]=find_matches(I1,pos1,I2)
points1 = pos1;
points2 = detectKAZEFeatures(rgb2gray(I2));
refPoints1 = detectBRISKFeatures(rgb2gray(I1));
refPoints2 = detectBRISKFeatures(rgb2gray(I2));
%%step2:Extract features around interest points.
%%Using the KAZE method to extract features of points1 and points2
%%in two images(obtain the same class of descriptor)
%%which makes the function robust to different points1 detected by
%%different methods.
%%Features of reference points are extracted by default method(FREAK).
%%FeatureSize of 128 can help extract more accurate features 
[f1, vpts1] = extractFeatures(rgb2gray(I1), points1,'FeatureSize',128,'Method','KAZE');
[f2, vpts2] = extractFeatures(rgb2gray(I2), points2,'FeatureSize',128,'Method','KAZE');
[ref_f1, refVpts1] = extractFeatures(rgb2gray(I1), refPoints1,'FeatureSize',128);
[ref_f2, refVpts2] = extractFeatures(rgb2gray(I2), refPoints2,'FeatureSize',128);
%%step3:Match interest points by features.
%%Using matchFeature to calculate the similarity of interest points in two images.
%%Seting the MaxRatio and MatchThreshold to maximum to obtain more possible matches.
%%but some outliers may not be deleted
[indexPairs,matchmetric] = matchFeatures(f1, f2,'MaxRatio',1,'MatchThreshold',100);
[refIndexPairs,refMatchmetric_] = matchFeatures(ref_f1, ref_f2,'MaxRatio',1,'MatchThreshold',100);
matchedPoints1 = vpts1(indexPairs(:, 1));
matchedPoints2 = vpts2(indexPairs(:, 2));
refMatchedPoints1 = refVpts1(refIndexPairs(:, 1));
refMatchedPoints2 = refVpts2(refIndexPairs(:, 2));
matchedXY = [matchedPoints1.Location;refMatchedPoints1.Location];
refMatchedXY = [matchedPoints2.Location;refMatchedPoints2.Location];
%%Step4:Delete some outliers and generate final result
%%Using Reference match and MSAC algorithm to delete ouliers in the first match
%%Create the final matchSet
%%If the given points are in the inlier set(within 5.5 pixels), then store
%%this pair of match in the final matchSet.If not, repeat the above match
%%process again and store this match in the final matchSet.
%%set 'MaxNumTrials' to 10000 to increase robustness
[tformTotal,inlierI1XY,inlierI2XY] = estimateGeometricTransform(matchedXY,refMatchedXY,'similarity','MaxNumTrials',10000);
final_match1 = zeros(size(pos1,1),2);
final_match2 = zeros(size(pos1,1),2);
for i = 1:size(pos1,1)
    for m = 1:size(inlierI1XY,1)
        if  sqrt((pos1(i,1) - inlierI1XY(m,1))^2 + (pos1(i,2) - inlierI1XY(m,2))^2) < 5.5
            final_match1(i,:) = inlierI1XY(m,:);
            final_match2(i,:) = inlierI2XY(m,:);
        end
    end
end
for j = 1:size(pos1,1)
     if  final_match1(j,:) == 0
            final_match1(j,:) = pos1(j,:);
            [f3, vpts3] = extractFeatures(rgb2gray(I1),final_match1(j,:),'FeatureSize',128,'Method','KAZE','Upright',true);
            [f4, vpts4] = extractFeatures(rgb2gray(I2), points2,'FeatureSize',128,'Method','KAZE', 'Upright',true);
            finalIndexPairs = matchFeatures(f3, f4,'MaxRatio',1,'MatchThreshold',100);
            final_match2(j,:) = vpts4(finalIndexPairs(:, 2)).Location;        
     end     
end
figure; showMatchedFeatures(I1,I2,pos1,final_match2,'montage');
legend('matched points 1',' matched points 2');
pos2 = final_match2;



