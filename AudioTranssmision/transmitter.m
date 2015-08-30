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

clc; clear all; close all;

% paths
addpath('TransmitterFunctions');
addpath('CommonFunctions');

% package loading (if octave)
isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
  more off;
  pkt load signal;
  pkt load communications;
end

% saved parameters
load('parameters.mat');

% other variables
img = imread('Images/estrella.jpg') > 128;
img = img(:,:,1);
[imgRows, imgCols] = size(img);
pktCounter =  0;
sendPause = 0.3;

% metadata pkt 
metadataPkt = genPkt([de2bi(imgRows, 8) de2bi(imgCols, 8)], 0);

% initial handshake
hsResp = handshakeTx();
%disp(metadataPkt);

% metadata packet transmission
while true
  pause(sendPause);
  disp('Sending metapacket.');
  sendData(metadataPkt);
  hsResp = handshakeTx();
  if hsResp
    break
  end
end

% data packet transmission
while true
  if pktCounter >= imgRows
    break
  end 
  % single packet transmission
  imgPkt = genPkt(img(pktCounter+1, :), pktCounter+1);
  while true
    pause(sendPause);
    disp(strcat(['Sending packet ', num2str(pktCounter+1)]));
    sendData(imgPkt);
    hsResp = handshakeTx();
    if hsResp
      pktCounter = pktCounter + 1;
      break
    end
  end
end

% finished!
disp('finished!');
