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

function detection = recAndDetectHs(recObj)
%% Function record and detect handshake
%  Record an audio sample, and detect if in the sample there was
%  a 0, a 1 or neither (neither of the frquencies pass the threshold).
%  In the last case this function return NaN
%
%  Inputs:
%  recObj: record object
%
%  Outputs:
%  detection: true: Fm1, false Fm0, Nan: neither
  
  % global variables
  global Fs;
  global tBitHandshake;
  global hsThres;
  
  % other variables
  tRec = tBitHandshake;
  Fm0temp = genSignal(false, tBitHandshake);
  Fm1temp = genSignal(true, tBitHandshake);
  sampBit = Fs*tBitHandshake;
  
  % record and get signal
  recordblocking(recObj, tRec);
  y = getaudiodata(recObj);
  % make correlations
  corrFm0 = xcorr(Fm0temp, y);
  corrFm1 = xcorr(Fm1temp, y);
  % make detection desicion
  detection = NaN;
  maxFm0 = max(corrFm0);
  maxFm1 = max(corrFm1);
  maxFm = max(maxFm0, maxFm1);
  if maxFm > hsThres
    if maxFm0 > maxFm1
      detection = false;
    else
      detection = true;
    end
  end
end
