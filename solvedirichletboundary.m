function [x1,x2] = solvedirichletboundary(I1,sigma,h1,h2)

[X,Y,~]=size(I1);

N=X*Y;

[weight,edges] = weight_w(I1,sigma); 

W = sparse([edges(:,1);edges(:,2)],[edges(:,2);edges(:,1)],[weight;weight],N,N);
y = sparse((1:N)',(1:N)',h1+h2,N,N);
D = diag(sum(W)) + y;

L = D - W;

B1 = h1';

x1 = L\B1';

x1 = reshape(x1,[X,Y]);
x2 = 1 - x1;











