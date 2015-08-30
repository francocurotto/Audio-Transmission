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

%% Function EDC Check
%  Check if packet contains error, using the error correction check
%  (Fletcher verification)
%
%  Inputs:
%  packet: packet as binary array
%
%  Outputs:
%  clean: true: no error detected, false: error detected
function clean = EDCCheck(packet)
  
  % global variables
  global initCode;
  
  % other variables
  clean = true;
  
  % extract packet initCode, EDC and data
  initCodeRx = packet(1:2);
  EDCRx = bi2de(packet(3:6));
  data = packet(7:end);
  
  % check for initCode error
  if initCode(1) ~= initCodeRx(1) || initCode(2) ~= initCodeRx(2)
    clean = false;
  end 
  
  % check for EDC error
  [~, computedEDC] = fletcherVerification(data);
  if computedEDC ~= EDCRx
    clean = false;
  end
end
