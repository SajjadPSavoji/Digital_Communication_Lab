function [det_sym] = min_dist_detector(r, constellation)
    det_sym = r;
    for i=1:length(r)
        [~, indx] = min(abs(r(i)-constellation));
        det_sym(i) = constellation(indx);
    end
end