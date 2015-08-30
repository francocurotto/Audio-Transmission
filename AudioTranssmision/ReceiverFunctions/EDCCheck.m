%% Function EDC Check
%  Check if packet contains error, using the error correction check
%  (Fletcher verification)
%
%  Inputs:
%  packet: packet as binary array
%
%  Outputs:
%  clean: true: no error detected, false: error detected
function clean = EDCCheck(packet)
  
  % global variables
  global initCode;
  
  % other variables
  clean = true;
  
  % extract packet initCode, EDC and data
  initCodeRx = packet(1:2);
  EDCRx = bi2de(packet(3:6));
  data = packet(7:end);
  
  % check for initCode error
  if initCode(1) ~= initCodeRx(1) || initCode(2) ~= initCodeRx(2)
    clean = false;
  end 
  
  % check for EDC error
  [~, computedEDC] = fletcherVerification(data);
  if computedEDC ~= EDCRx
    clean = false;
  end
end