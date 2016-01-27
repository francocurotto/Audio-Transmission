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

function rawData = packetRx(pktLen)
%% Function packet receive
%  Record the audio of the data transmission and convert it
%  into a binary array
%
%  Inputs:
%  pktLen: expected packet length
%
%  Outputs:
%  rawData: data binary array
  
  % global variables
  global Fs;
  global tBit;
  global pktThres;
  
  % other variables
  recObj = audiorecorder(Fs, 16, 1);
  tRec = tBit*pktLen + 2;
  Fm0temp = genSignal(false, tBit);
  Fm1temp = genSignal(true, tBit);
  sampBit = Fs*tBit;
  
  % record and get signal
  recordblocking(recObj, tRec);
  y = getaudiodata(recObj);
  % make correlations
  corrFm0 = xcorr(Fm0temp, y);
  corrFm0 = fliplr(corrFm0(1:sampBit+length(y)));
  corrFm1 = xcorr(Fm1temp, y);
  corrFm1 = fliplr(corrFm1(1:sampBit+length(y)));
  % filter correlations
  corrFm0Filt = abs(hilbert(corrFm0));
  corrFm1Filt = abs(hilbert(corrFm1));
  corrFm0Filt = corrFm0Filt./max(corrFm0Filt);
  corrFm1Filt = corrFm1Filt./max(corrFm1Filt);
  % detect start of packet (initial bit)
  try
    overThres = corrFm1Filt > pktThres;
    peakBounds = find(diff(overThres), 2);
    [~,initBit] = max(corrFm1Filt(peakBounds(1):peakBounds(2)));
    initBit = initBit + peakBounds(1) - 1;
    % get binary data
    bitPos = initBit : sampBit : initBit+sampBit*(pktLen-2);
    rawData = corrFm0Filt(bitPos) < corrFm1Filt(bitPos);
  % if error assign all 1's (will procude a checksum detection)
  catch
    rawData = logical(ones(1, 8));
  end
  
  disp(strcat(['Received: ', num2str(rawData)]));
end
