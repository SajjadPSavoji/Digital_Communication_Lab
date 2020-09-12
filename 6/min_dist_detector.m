function [det_sym] = min_dist_detector(r, constellation)
    [~, indx] = min(abs(r-constellation.'));
    det_sym = constellation(indx);
end