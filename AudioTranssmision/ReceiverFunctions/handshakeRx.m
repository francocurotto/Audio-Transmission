%% Function handshake reception
%  Initiate a positive or negative 3 way handshake with the transmitter.
%  Positive handshake means the last packet was correctly recived
%  and now its waiting for the next packet.
%  Negative handshake means last packet was corrupted, and
%  its waiting for the same packet to be retransmitted
%
%  Inputs:
%  type: true = positive handshake, false = negative handshake
function handshakeRx(type)
  
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