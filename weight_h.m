function [h1,h2] = weight_h(map1_guided,map2_guided,alpha1,alpha2)

%% weight_h1
number1 = imhist(map1_guided);

[~,bb] = sort(number1);
number1(bb(end-1:end)) = 0;
side_number = sum(number1) * (1-alpha1) / 2;
cc = cumsum(number1) - side_number;
cc(cc<0) = -1;
low_bound1 = find(cc > -1);
low_bound1 = low_bound1(1);
low_bound1 = low_bound1/256;

side_number = sum(number1) * (1+alpha1) / 2;
cc = cumsum(number1) - side_number;
cc(cc<0) = -1;
up_bound1 = find(cc > -1);
up_bound1 = up_bound1(1);
up_bound1 = up_bound1/256;

map1_guided(map1_guided<0) = 0;
h1 = zeros(size(map1_guided));
h1(map1_guided >= low_bound1 & map1_guided <= up_bound1) = 0;
h1(map1_guided < low_bound1) = 1;
h1(map1_guided > up_bound1) = 1;

%% weight_h2
number2 = imhist(map2_guided);

[~,bb] = sort(number2);
number2(bb(end-1:end)) = 0;
side_number = sum(number2) * (1-alpha2) / 2;
cc = cumsum(number2) - side_number;
cc(cc<0) = -1;
low_bound2 = find(cc > -1);
low_bound2 = low_bound2(1);
low_bound2 = low_bound2/256;

side_number = sum(number1) * (1+alpha2) / 2;
cc = cumsum(number1) - side_number;
cc(cc<0) = -1;
up_bound2 = find(cc > -1);
up_bound2 = up_bound2(1);
up_bound2 = up_bound2/256;

map2_guided(map2_guided<0) = 0;
h2 = zeros(size(map2_guided));
h2(map2_guided >= low_bound2 & map2_guided <= up_bound2) = 0;
h2(map2_guided < low_bound2) = 1;
h2(map2_guided > up_bound2) = 1;






