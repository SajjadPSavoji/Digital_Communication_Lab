function [y] = upsmpl(x,u)
    s = size(x);
    y = zeros(1, s(2)*u - u +1);
    y(1:u:end) = x(1:end);
end