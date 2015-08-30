%% Function record and detect handshake
%  Record an audio sample, and detect if in the sample there was
%  a 0, a 1 or neither (neither of the frquencies pass the threshold).
%  In the last case this function return NaN
%
%  Inputs:
%  recObj: record object
%
%  Outputs:
%  detection: true: Fm1, flase Fm0, Nan: neither
function detection = recAndDetectHs(recObj)
  
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
  %corrFm0 = fliplr(corrFm0(1:sampBit+length(y)));
  corrFm1 = xcorr(Fm1temp, y);
  %corrFm1 = fliplr(corrFm1(1:sampBit+length(y)));
%   figure(1); plot(corrFm1); hold on; plot(corrFm0, 'g'); hold off;
  % make detection desicion
  detection = NaN;
  maxFm0 = max(corrFm0);
  maxFm1 = max(corrFm1);
  %maxFm0 
  %maxFm1
  maxFm = max(maxFm0, maxFm1);
  if maxFm > hsThres
    if maxFm0 > maxFm1
      detection = false;
    else
      detection = true;
    end
  end
end
