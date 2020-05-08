function yvec = dots2func(x,y,xvec)
% dots2func Dots to function
%   Takes the set of points (x,y), computes the line equations
%   and evaluates them on xvec
yvec = zeros(size(xvec));
for k = 1:size(x,1)
    m = (y(k,2)-y(k,1))/(x(k,2)-x(k,1));
    b = y(k,2) - m*x(k,2);
    ind = (x(k,1) <= xvec) & (xvec <= x(k,2)); 
    yvec(ind) = m.*xvec(ind) + b;
end
end

