function [b_gray] = gray_code(k)
    A = [0; 1];
    for i = 1:k-1
        A = [zeros(2^i,1) A; ones(2^i,1) flip(A)];
    end
    b_gray = A;
end