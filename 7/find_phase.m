function [ph, idx] = find_phase(rx_smpl_noise,hder_smpl)    
    kernel = conj(fliplr(hder_smpl));
    crr = conv(kernel, rx_smpl_noise);
    [~, idx] = max(crr);
    
    ph = angle(crr(idx));
end