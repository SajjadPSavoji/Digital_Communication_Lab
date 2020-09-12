function [det_sym_idx, rec_sym_tot] = pulse_demodulation_fsk(rx_signal, M, fs, smpl_per_symbl, pulse_name, ~, varargin)
    Ts = smpl_per_symbl / fs;
    delta_f = 0.5 / Ts;
    [waves, ~] = FSK_pulse_generator(pulse_name, fs, smpl_per_symbl, M, delta_f, cell2mat(varargin));

    corr_tot = zeros(M, length(rx_signal)/smpl_per_symbl);
    for m=1:M
        rec_sym = zeros(1, size(corr_tot, 2));
        for i = 1:size(corr_tot, 2)
            rec_sym(i) = sum(conj(waves(m,:)).*rx_signal((i-1)*smpl_per_symbl +1:i*smpl_per_symbl));
        end
        corr_tot(m,:) = real(rec_sym);
    end
    [rec_sym_tot, det_sym_idx] = max(corr_tot);
end