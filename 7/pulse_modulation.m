function [tx_smpl, cons] = pulse_modulation(sym_idx, modulation, M, fs, smpl_per_symbl, pulse_name, mode, varargin)
    
    if strcmp(modulation, 'fsk')
        Ts = smpl_per_symbl / fs;
        if strcmp(varargin(1), 'noncoherent')
            delta_f = 1 / Ts;
        else
            delta_f = 0.5 / Ts;
        end
        cons = 1:M;
        coefs = cons(sym_idx);
        [p, ~] = FSK_pulse_generator(pulse_name, fs, smpl_per_symbl, M, delta_f, cell2mat(varargin));
        signal = zeros(M, (length(coefs)*smpl_per_symbl));
        for m = 1:M
            y = upsmpl(coefs, smpl_per_symbl);
            signal(m,:) = conv(double(y == m), p(m,:));
        end
        tx_smpl = sum(signal);
    else
        [cons, ~]  = constellation(M, modulation);
        coefs = cons(sym_idx);
        [p, ~] = pulse_shape(pulse_name, fs, smpl_per_symbl, cell2mat(varargin));
        if strcmp(mode, 'kron')
            tx_smpl = kron(coefs, p);
        elseif strcmp(mode, 'conv')
            y = upsmpl(coefs, smpl_per_symbl);
            tx_smpl = conv(y, p);
        else
            echo('mode not supported')
        end
    end
end