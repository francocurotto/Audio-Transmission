# Audio-Transmission
Transmits a binary (black-and-white) image between two computers using sound.

## Explanation:
One computers wants to transmit a (small) binary image between to another
computer via audio signals. the transmitter computer "packetize" the image 
converting every column of the image in a individual packet, and then into an 
audio signal that is reproduced by the speaker. The second computer receives the
packet and check for possible errors in the data. If everything is ok, it 
request the next packet, if the data is corrupted, it request the same packet
(Stop and Wait ARQ). The system also uses an initial metadata packet that sends
the size (length and width) of the image, allowing the transmission of images of
variable size (up to 255 x 255).  

## How to use:
1. Run saveParamenters.m on both, transmitter and receiver computers (this save 
the correct parameters in parameters.mat)
2. Run transmitter.m and receiver.m in the correspondent computer (order is 
irrelevant). 

## Features
- Modulation: FSK, 2 frecuencies
  * Fm0: 4000 [Hz]
  * Fm1: 2000 [Hz]
- Sampling frecuency: 44100 [Hz]
- Maximum image size: 255 x 255 [px]
- Packetization : By rows
- Synchronization : 3 Way Handshake
- Error detection algorithm: Fletcher’s Checksum
- Overhead packets: 7 bits

## Author Information
Author: Franco Curotto
Email: francocurotto@gmail.com
Thanks to Ivan Castro for the implementation of the Fletcher Checksum 
