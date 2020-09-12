function [idx] = find_header(rx_smpl_noise,hder_smpl)
    kernel = conj(fliplr(hder_smpl));
    crr = conv(kernel, rx_smpl_noise);
    [~, idx] = max(crr);
    
    idx = idx - length(kernel) + 1;
end