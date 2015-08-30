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

%% Function generate packet
%  Creates a packet for transmission, given the data
%
%  Inputs:
%  Data: data to packetize
%  Seq: sequence number
%
%  Outputs:
%  packet: final packet
function packet = genPkt(data, seq)
  
  % global variables
  global initCode;
  
  % other variables
  dummy = data(end);
  seqBit = logical(mod(seq, 2));
  
  % add sequence parity to data
  data = [seqBit data];
  
  % generate EDC
  [EDC,~] = fletcherVerification(data);
  
  % add initial code, EDC, and dummy to the data
  packet = [initCode EDC data dummy];
end
