%% Function generate signal
%  Generate an audio signal to transmit a packet of data,
%  given audio information
%
%  Inputs:
%  pkt: packet to transform in signal
%  tBit: time of bitand
function signal = genSignal(pkt, tBit)
  
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
