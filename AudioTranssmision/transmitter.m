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
