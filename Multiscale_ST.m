function [map1,map2] = Multiscale_ST(I1,I2,sigma1,sigma2)

if ~exist('sigma1','var')
    sigma1 = 3;
end

if ~exist('sigma2','var')
    sigma2 = 8;
end

[dx1, dy1] = GradientMethod(I1, 'zhou'); 
[dx2, dy2] = GradientMethod(I2, 'zhou');
dxdy1 = dx1+1i*dy1;
dxdy2 = dx2+1i*dy2;


[~, ~, measure1_sigma1, measure2_sigma1] = WeightGradient(dxdy1, dxdy2, sigma1);
map1 = double(measure1_sigma1 > (measure2_sigma1 + 0));

[~, ~, measure1_sigma2, measure2_sigma2] = WeightGradient(dxdy1, dxdy2, sigma2);
map2 = double(measure1_sigma2 > (measure2_sigma2 + 0));




