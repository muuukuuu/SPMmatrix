function signal=olegNoise

samplingFrequency = 1000; %Hz
recordingTime = 1; %s

PSDFunction = @(f) double(f > 50 && f < 100); %Low-pass filter

totalTimeSamples = recordingTime * samplingFrequency;
timeResolution = 1 / samplingFrequency;
time = timeResolution * (0 : totalTimeSamples-1);

signal = TimeSeriesFromPSD( PSDFunction, samplingFrequency, recordingTime );

subplot( 211 )
plot( time, signal );
xlabel( 'Time [s]' );
title( 'Time signal' );

[pxx, w] = periodogram( signal );
subplot( 212 )
plot( w/pi*samplingFrequency/2, pxx );
xlabel( 'Frequency [Hz]' )
title( 'Periodogram' )