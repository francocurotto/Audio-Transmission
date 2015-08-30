% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.

% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
