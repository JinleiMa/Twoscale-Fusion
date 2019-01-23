function [FocusMap,Fused] = TwoScale_Fusion(I1,I2)

img1 = I1;img2 = I2;

if size(I1,3) == 3
    I1 = rgb2gray(I1);
    I2 = rgb2gray(I2);
end

% structure-based focus measure for generating two-scale focus maps
sigma1 = 3;
sigma2 = 8;
[map1,map2] = Multiscale_ST(I1,I2,sigma1,sigma2);

% improve the two-scale focus maps using the guided filter
r1 = 5;
eps1 = 10^(-2);

r2 = 11;
eps2 = 10^(-2);

[map1_guided,map2_guided] = Multiscale_Guided(I1, map1, map2, r1, eps1, r2, eps2);

% weight h_ik
alpha1 = 0.9;
alpha2 = 0.8;

[h1,h2] = weight_h(map1_guided,map2_guided,alpha1,alpha2);

% sparse data interpolation for efficient estimation
sigma = 0.02;
g = uint8(I1 * 255);
h = h1 + h2;
F1 = FGS(h1, g, sigma);
F2 = FGS(h, g, sigma);
x1 = F1 ./ (F2 + eps(F2));
x2 = 1 - x1;

% generating the estimated focus map
FocusMap = zeros(size(map1_guided));
FocusMap(x1 >= x2) = map1_guided(x1 >= x2);
FocusMap(x2 >= x1) = map2_guided(x2 >= x1);

% construct the fused image
if size(img1,3) == 1
    Fused = FocusMap.*img1 + (1-FocusMap).*img2;
else
    Fused(:,:,1) = FocusMap.*img1(:,:,1) + (1-FocusMap).*img2(:,:,1);
    Fused(:,:,2) = FocusMap.*img1(:,:,2) + (1-FocusMap).*img2(:,:,2);
    Fused(:,:,3) = FocusMap.*img1(:,:,3) + (1-FocusMap).*img2(:,:,3);
end


end