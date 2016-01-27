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

function handshakeRx(type)
%% Function handshake reception
%  Initiate a positive or negative 3 way handshake with the transmitter.
%  Positive handshake means the last packet was correctly recived
%  and now its waiting for the next packet.
%  Negative handshake means last packet was corrupted, and
%  its waiting for the same packet to be retransmitted
%
%  Inputs:
%  type: true = positive handshake, false = negative handshake  
  
  % global variables
  global Fs;
  global tBitHandshake;
  
  % decide handshake type
  if type
    signalSYN = genSignal(true, tBitHandshake);
    signalACK = genSignal(false, tBitHandshake);
  else
    signalSYN = genSignal(false, tBitHandshake);
    signalACK = genSignal(true, tBitHandshake); 
  end
  
  % audio recorder and players creation
  recObj = audiorecorder(Fs, 16, 1);
  playerSYN = audioplayer(signalSYN, Fs, 16);  
  playerACK = audioplayer(signalACK, Fs, 16);
  
  % handshake loop
  while true
  % send SYN signal
  playblocking(playerSYN);
  % detect ACK-SYN
  detection = recAndDetectHs(recObj);
  % if ACK-SYN detected, send ACK and finish handshake
  if detection == type
    playblocking(playerACK);
    break
  end
end
