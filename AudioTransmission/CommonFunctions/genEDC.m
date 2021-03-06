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

function [EDCbin, EDCdec] = genEDC(data)
%% Generate Error Detection Code
%  Generate the EDC of 4 bits for specific string (array) of data. The 
%  EDC is a 4 bit number
%
% Inputs: 
% data: data in binary
%
% Outputs: 
% EDCbin: Error Detection Code in binary
% EDCdec: Error Detection Code in decimal
  
  EDCdec = mod(bi2de(data), 8);
  EDCbin = de2bi(EDCdec);
  
end
