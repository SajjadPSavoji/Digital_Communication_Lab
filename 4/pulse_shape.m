function [p, t] = pulse_shape(pulse_name, fs, smpl_per_symbl, varargin)
    Ts = smpl_per_symbl / fs;
    t = (0:1:smpl_per_symbl-1)/fs;
    switch pulse_name
    case 'rectangular'
        temp_p = (1./sqrt(Ts)) * ones(1,smpl_per_symbl);
    case 'triangular'
        temp_p = max((Ts/2)-abs(t-(Ts/2)), 0);
    case 'sine'
        temp_p = sin((pi.*t)./Ts);
    otherwise
        disp('There is no pulse like this!')
    end
    E_p = sum(abs(temp_p).^2);
    p = temp_p./sqrt(E_p);
end