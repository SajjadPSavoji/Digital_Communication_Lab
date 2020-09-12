function [cons, Es_avg] = constellation(M, modulation)
    switch modulation
    case 'pam'
        Am = -(M-1):2:(M-1);
        E_sum = ((M^2)-1)/3;
        cons = Am./sqrt(E_sum);
    case 'psk'
        m = 1:M;
        cons_real = cos((2*pi/M)*(m-1));
        cons_imag = sin((2*pi/M)*(m-1));
        cons = (cons_real + 1i.*cons_imag);
    case 'qam'
        if (rem(log2(M),2) == 0)
            E_sum = (2*(M-1))/3;
            Ami = -(sqrt(M)-1):2:(sqrt(M)-1);
            Amq = -(sqrt(M)-1):2:(sqrt(M)-1);
            temp_cons = Ami .* ones(sqrt(M),sqrt(M));
            for i=1:sqrt(M)
                temp_cons(i,:) = temp_cons(i,:) + 1i.*Amq(i);
            end
            cons = zeros(size(temp_cons));
            for i=1:sqrt(M)
                if (rem(i,2) == 0)
                    cons(:,i) = flip(temp_cons(:,i))./sqrt(E_sum);
                else
                    cons(:,i) = temp_cons(:,i)./sqrt(E_sum);
                end
            end
            cons = cons(:).';
        elseif M == 8
            M1 = 4;
            M2 = 2;
            Ami = -(M1-1):2:(M1-1);
            Amq = -(M2-1):2:(M2-1);
            temp_cons = Ami .* ones(M2, M1);
            for i=1:M2
                temp_cons(i,:) = temp_cons(i,:) + 1i.*Amq(i);
            end
            E_sum = sum(sum(abs(temp_cons).^2))/(M1*M2);
            cons = zeros(size(temp_cons));
            for i=1:M1
                if (rem(i,2) == 0)
                    cons(:,i) = flip(temp_cons(:,i))./sqrt(E_sum);
                else
                    cons(:,i) = temp_cons(:,i)./sqrt(E_sum);
                end
            end
            cons = cons(:).';
        elseif M == 32
            M1 = 6;
            M2 = 6;
            Ami = -(M1-1):2:(M1-1);
            Amq = -(M2-1):2:(M2-1);
            temp_cons = Ami .* ones(M2, M1);
            for i=1:M2
                temp_cons(i,:) = temp_cons(i,:) + 1i.*Amq(i);
            end
            temp_cons = temp_cons(:);
            temp_cons([1,M2,((M1-1)*M2)+1,M1*M2]) = [];
            E_sum = sum(abs(temp_cons).^2)/(length(temp_cons));
            cons = temp_cons./sqrt(E_sum).';
        end
    otherwise
        disp('There is no modulation like this!')
    end
    Es_avg = 1;
end