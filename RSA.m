clc;%Clear command window
disp('RSA Encrypt-Decrypt Algorithm');
disp('-----------------------------------------');
clear all; close all;%Clear variables in workspace and close figure

%Input value of p and q
p = input('\nEnter a prime value p: ');
q = input('\nEnter a prime value q: ');


N=p*q;%Calculate value of n
tf=(p-1)*(q-1);%Calculate value of totien function

%Calculate the value of e
e = NaN;
    
    for i = 3 : 2 : tf - 1
        if gcd(i, tf) == 1
            e = int32(i);
            break
        end
    end
    
    if isnan(e)
        error('No relative prime between p - 1 and q - 1 was found.')
    end

%Calculate the value of d
a = int32(e);
    b = int32(tf);

    x = int32(0);
    y = int32(1);
    u = int32(1); 
    v = int32(0);
    
    while a ~= 0
        q = idivide(b, a);
        r = mod(b, a);
        m = x - u*q; 
        n = y - v*q;
        b = a;
        a = r;
        x = u;
        y = v;
        u = m;
        v = n;
    end
    d=x;
       if d < 0
           d = tf + d;
    end
%clc;
disp(['N is: ' num2str(N)]);
disp(['Totien function is: ' num2str(tf)]);
disp(['Public key (e) is: ' num2str(e)]);
disp(['Private key (d) is: ' num2str(d)]);

P = input('\nEnter a message to be sent: ','s');
c = double(P);
disp('Plain text: ');
disp(P);

disp('ASCII Plain text: ');
disp(c);

%Encrypt
disp('Cipher Text: ');
cipher=maths(c,e,N)


disp('Decrypted ASCII Text: ');
%Decrypt
plain=maths(cipher,d,N)


disp('Decrypted message: ');
disp(char(plain));%Convert double to char


function Result = maths(Base, Exponent, Modulus)

    Result          = 1;
    TempExponent    = 0;
    
    while true
        
        TempExponent    = TempExponent + 1;        
        Result          = mod((Base .* Result), Modulus);
        
        if TempExponent == Exponent
            break
        end
        
    end
    
end
