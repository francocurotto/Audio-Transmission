%% Function generate packet
%  Creates a packet for transmission, given the data
%
%  Inputs:
%  Data: data to packetize
%  Seq: sequence number
%
%  Outputs:
%  packet: final packet
function packet = genPkt(data, seq)
  
  % global variables
  global initCode;
  
  % other variables
  dummy = data(end);
  seqBit = logical(mod(seq, 2));
  
  % add sequence parity to data
  data = [seqBit data];
  
  % generate EDC
  [EDC,~] = fletcherVerification(data);
  
  % add initial code, EDC, and dummy to the data
  packet = [initCode EDC data dummy];
end