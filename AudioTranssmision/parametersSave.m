% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.

% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
