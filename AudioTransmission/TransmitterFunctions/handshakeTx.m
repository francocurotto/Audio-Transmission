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

function type = handshakeTx()
%% Function handshake transmission
%  Follows a 3 way handshake initiated by the receptor, and
%  detect the handshake type (positive or negative).
%
%  Output:
%  type: true = positive handshake, false = negative handshake
  
  % global variables
  global Fs;
  global tBitHandshake;
  
  % audio recorder creation
  recObj = audiorecorder(Fs, 16, 1);
  
  % handshake loop
  while true
  % detect SYN type
  pause(0.3);
  type = recAndDetectHs(recObj);
  % if SYN detected, send ACK-SYN of the same type
  if ~isnan(type)
    signalACKSYN = genSignal(type, tBitHandshake);
    playerACKSYN = audioplayer(signalACKSYN, Fs, 16);
    pause(0.3);
    playblocking(playerACKSYN);
    pause(0.3);
    % detect ACK
    detection = recAndDetectHs(recObj);
    % if ACK detected, finish handshake
    if detection == ~type
      break
    end
  end
end
