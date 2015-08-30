%% Function send data
%  Transform the data into a signal and send it to the reciever
%
%  Inputs:
%  data: data to send
function sendData(data)
  
  % global variables
  global Fs;
  global tBit;
  
  % other variables
  dataSignal = genSignal(data, tBit);
  player = audioplayer(dataSignal, Fs, 16);
  disp(strcat(['Sending: ', num2str(data)]));
  
  % send data
  playblocking(player);
end