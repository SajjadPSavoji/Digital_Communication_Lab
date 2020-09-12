function [tx_smpl, cons] = pulse_modulation(sym_idx, modulation, M, fs, smpl_per_symbl, pulse_name, mode, varargin)
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