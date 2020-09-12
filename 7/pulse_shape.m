function [p, t] = pulse_shape(pulse_name, fs, smpl_per_symbl, varargin)
    extra_param = cell2mat(varargin);
    Ts = smpl_per_symbl / fs;
    switch pulse_name
        case 'rectangular'
            t = (0:1:smpl_per_symbl-1)/fs;
            temp_p = (1./sqrt(Ts)) * ones(1,smpl_per_symbl);
        case 'triangular'
            t = (0:1:smpl_per_symbl-1)/fs;
            temp_p = max((Ts/2)-abs(t-(Ts/2)), 0);
        case 'sine'
            t = (0:1:smpl_per_symbl-1)/fs;
            temp_p = sin((pi.*t)./Ts);
        case 'raised_cosine'
            beta = extra_param(1);
            span_in_symbl = extra_param(2);
            t = ( (-span_in_symbl*Ts/2) : (1/fs) : ((span_in_symbl*Ts/2)-(1/fs)) );
            temp_p = sinc(t/Ts).*cos(pi.*beta.*t/Ts)./(1 - (4.*(beta.^2).*(t.^2)/(Ts^2)));
        case 'root_raised_cosine'
            beta = extra_param(1);
            span_in_symbl = extra_param(2);
            t = ( (-span_in_symbl*Ts/2) : (1/fs) : ((span_in_symbl*Ts/2)-(1/fs)) );
            syms tt
            eq1 = (1/sqrt(Ts)) * (1-beta+((4*beta)/pi)) ;
            eq2 = (beta/sqrt(2*Ts)) * ((1+(2/pi))*sin(pi/(4*beta)) + (1-(2/pi))*cos(pi/(4*beta)));
            eq3 = (1/sqrt(Ts)) .* ...
                (sin(pi.*tt.*(1-beta)./Ts) + (4*beta/Ts).*tt.*cos(pi.*tt.*(1+beta)./Ts)) ./ ...
                ((pi.*tt/Ts) .* (1 - ((4*beta/Ts).*tt).^2));
            h_rrc = piecewise(tt == 0, eq1, abs(tt) == (Ts/(4*beta)), eq2, eq3);
            temp_p = double(subs(h_rrc, tt, t));
        case 'gaussian'
            beta = extra_param(1);
            span_in_symbl = extra_param(2);
            t = ( (-span_in_symbl*Ts/2) : (1/fs) : ((span_in_symbl*Ts/2)-(1/fs)) );
            temp_p = (qfunc(2*pi*beta*(t-(Ts/2))/Ts) - qfunc(2*pi*beta*(t+(Ts/2))/Ts))/log(2);
        otherwise
            disp('There is no pulse like this!')
    end
    E_p = sum(abs(temp_p).^2);
    p = temp_p./sqrt(E_p);
end