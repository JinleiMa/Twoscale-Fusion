
function [map1_guided,map2_guided] = Multiscale_Guided(I1, map1, map2, r1, eps1, r2, eps2)

map1 = logical(map1);
map2 = logical(map2);


map1_guided = guidedfilter(I1, map1, r1, eps1);

map2_guided = guidedfilter(I1, map2, r2, eps2);


end