function [img] = toy_reconstruct(s)
[imh, imw, nb] = size(s);
im2var = zeros(imh, imw);
im2var(1:imh*imw) = 1:imh*imw; 

A = sparse([], [], [], imh*imw*2 + 1, imh*imw);
b = zeros(imh*imw*2 + 1,1);

e = 1;
%objective1
% minimize (v(y+1,x)-v(y,x) - (s(y+1,x)-s(y,x)))^2 
for y = 1:imh - 1
    for x = 1:imw
        A(e,im2var(y + 1,x)) = 1;
        A(e, im2var(y,x)) = -1;
        b(e) = s(y + 1,x)-s(y,x);  
        e = e+1;
    end
end
% Objective 2
% minimize (v(y,x+1)-v(y,x) - (s(y,x+1)-s(y,x)))^2 
for y = 1:imh
    for x = 1:imw - 1
        A(e,im2var(y,x + 1)) = 1;
        A(e, im2var(y,x)) = -1;
        b(e) = s(y,x + 1)-s(y,x);  
        e = e+1;
    end
end
% Objective 2
% minimize (v(1,1)-s(1,1))^2
A(e,im2var(1,1)) = 1;
b(e) = s(1,1);
v = lscov(A, b);
img = reshape(v, [imh,imw]);
end