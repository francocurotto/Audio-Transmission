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

function signal = genSignal(pkt, tBit)
%% Function generate signal
%  Generate an audio signal to transmit a packet of data,
%  given audio information
%
%  Inputs:
%  pkt: packet to transform in signal
%  tBit: time of bita
%
% Outputs:
% signal: audio signal
  
  % global variables
  global Fs;
  global Fm0;
  global Fm1;
  
  % other variables
  pktLen = length(pkt);   % packet length
  sampBit = Fs*tBit;      % samples per bit
  strchPkt = logical(kron(pkt, ones(1, sampBit))); % stretched packet
  t = linspace(0, tBit*pktLen, length(strchPkt)); % time vector
  
  % signal creation
  signal0bits = sin(2*pi*Fm0*t) .* ~strchPkt;
  signal1bits = sin(2*pi*Fm1*t) .* strchPkt;
  signal = signal0bits + signal1bits;
end  
