function [det_sym_idx, rec_sym_tot] = pulse_demodulation(rx_signal, modulation, M, fs, smpl_per_symbl, pulse_name, mode, varargin)
    if strcmp(modulation, 'fsk')
        [det_sym_idx, rec_sym_tot] = pulse_demodulation_fsk(rx_signal, M, fs, smpl_per_symbl, pulse_name, mode, cell2mat(varargin));
    else
        [p, ~] = pulse_shape(pulse_name, fs, smpl_per_symbl, cell2mat(varargin));
        [rec_sym_tot] = corr_match(rx_signal, p, smpl_per_symbl, mode);
        [cons, ~] = constellation(M, modulation);
        [det_sym] = min_dist_detector(rec_sym_tot, cons);
        det_sym_idx = zeros(1, length(det_sym));
        for i=1:M
            det_sym_idx(det_sym == cons(i)) = i;
        end
    end
end