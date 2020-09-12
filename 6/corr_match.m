function [rec_sym] = corr_match(r, p, smpl_per_symbl, mode)
    s = length(r);
    rec_sym = zeros(1, s/smpl_per_symbl);
    
    if strcmp(mode, 'correlator')
        for i = 1:s/smpl_per_symbl
            rec_sym(i) = sum(p.*r((i-1)*smpl_per_symbl +1:i*smpl_per_symbl));
        end
    elseif strcmp(mode, 'matched_filter')
        p = fliplr(p);
        y = conv(p, r);
        rec_sym = y(smpl_per_symbl:smpl_per_symbl:end);
    else
        echo('mode not supported')
    end
    rec_sym = rec_sym ./ sum(p.*p);
end