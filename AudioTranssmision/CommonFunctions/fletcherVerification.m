function [ver_digit,remainder] = fletcherVerification(data)
    
    data_half = floor(length(data)/2);

    data1 = data(1:data_half);
    data2 = data(data_half+1:length(data));

    dec_num1 = bi2de(data1);
    dec_num2 = bi2de(data2);

    sum_dec = dec_num1 + dec_num2;

    remainder = mod(sum_dec,16);

    ver_digit = de2bi(remainder, 4); % Verificacion F
    
    ver_digit = logical(ver_digit);

end