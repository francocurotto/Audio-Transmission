%% Function handshake transmission
%  Follows a 3 way handshake initiated by the receptor, and
%  detect the handshake type (positive or negative).
%
%  Output:
%  type: true = positive handshake, false = negative handshake
function type = handshakeTx()
  
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