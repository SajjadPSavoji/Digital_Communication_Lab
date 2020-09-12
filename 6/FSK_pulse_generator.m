function [p, t] = FSK_pulse_generator(pulse_name, fs, smpl_per_symbl, M, delta_f, varargin)
    p = zeros(M, smpl_per_symbl);    
    for m = 1:M
        [p(m,:), t] = pulse_shape(pulse_name, fs, smpl_per_symbl, cell2mat(varargin));
        p(m,:) = p(m,:) .* exp(1i*2*pi*(m-1)*delta_f*t);
        E_p = sum(abs(p(m,:)).^2);
        p(m,:) = p(m,:) ./ sqrt(E_p);
    end
end