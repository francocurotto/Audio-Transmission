clc; clear all; close all;
tic();

% paths
addpath('ReceiverFunctions');
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
nPkt = 0;
pktCounter = 0;
recImage = [];

% initial handshake
handshakeRx(true);

% metadata packet reception
while true
  rawMetadata = packetRx(24);
  %disp(rawMetadata);
  clean = EDCCheck(rawMetadata);
  if clean
    nPkt = bi2de(rawMetadata(8:15));
    pktLen = bi2de(rawMetadata(16:23)) + 8;
    disp('Metapacket recieved correctly!');
    break
  end
  handshakeRx(false);
end

% image data packets reception
while true
  handshakeRx(true);
  if pktCounter >= nPkt
    break
  end 
  % single packet reception
  while true
    rawData = packetRx(pktLen);
    clean = EDCCheck(rawData);
    if clean
      seqBit = rawData(7);
      if seqBit == mod(pktCounter+1, 2)
        recImage = [recImage; rawData(8:end)];
        pktCounter = pktCounter + 1;
        disp(strcat(['Package ', num2str(pktCounter), ' received correctly!']));
      end
      break
    end
    handshakeRx(false);
  end
end

%show image
h = figure(1);
imshow(recImage);
imgName = strrep(strcat(datestr(now), '.png'), ':', '-'); 
print(h, imgName, '-dpng');

% finished!
toc();
disp('finished!');
