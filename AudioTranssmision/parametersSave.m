clc; clear all;

global Fs, Fs = 44100;
global Fm0, Fm0 = 4000;
global Fm1, Fm1 = 2000;

global tBitHandshake, tBitHandshake = 1;
global tBit, tBit = 0.1;
global hsThres, hsThres = 500;
global pktThres, pktThres = 0.1;

global initCode, initCode = [true false];
global metadataPktLen = 24;

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
  save -mat-binary parameters.mat;
else
  save parameters.mat;
end