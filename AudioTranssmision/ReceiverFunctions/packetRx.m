%% Function packet receive
%  Record the audio of the data transmission and convert it
%  into a binary array
%
%  Inputs:
%  pktLen: expected packet length
%
%  Outputs:
%  rawData: data binary array
function rawData = packetRx(pktLen)
  
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
  %figure(1); plot(corrFm0); hold on; plot(corrFm1, 'g');
  % filter correlations
  corrFm0Filt = abs(hilbert(corrFm0));
  corrFm1Filt = abs(hilbert(corrFm1));
  corrFm0Filt = corrFm0Filt./max(corrFm0Filt);
  corrFm1Filt = corrFm1Filt./max(corrFm1Filt);
  %figure(2); plot(corrFm0Filt); hold on; plot(corrFm1Filt, 'g');
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
  %hold on; 
  %for i=1:pktLen-1
  %  plot([bitPos(i) bitPos(i)],[0 1], 'r'); 
  %end; 
  %hold off;
end