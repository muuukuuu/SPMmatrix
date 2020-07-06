function signal=olegNoise2_IS(PSD1)

% figure;
% PSD1=10*log10(PSD1);
% plot(PSD1)
% pause

samplingFrequency = 100; %Hz
recordingTime = 30; %s
recordingTime = (length(PSD1)-1)/samplingFrequency*2; %s

% PSDFunction = @(f) double(f > fl && f < fh) * (f+eps)^(-2); %Band-pass filter

totalTimeSamples = recordingTime * samplingFrequency;
timeResolution = 1 / samplingFrequency;
time = timeResolution * (1 : totalTimeSamples);
% time = timeResolution * (0 : totalTimeSamples-1);

% signal = TimeSeriesFromPSD( PSD1, samplingFrequency, recordingTime );
    totalFrequencyBins = floor( totalTimeSamples / 2 );
    frequencyResolution = samplingFrequency / 2 / totalFrequencyBins;

    frequency = frequencyResolution * (0 : totalFrequencyBins-1);
%     amplitude = sqrt( arrayfun( PSD, frequency ) );
    amplitude=sqrt( PSD1(1:length(PSD1)-1) );
%     amplitude=amplitude./max(amplitude);
    
    phase = 2*pi * rand( 1, totalFrequencyBins );
    
    y = zeros( 1, totalTimeSamples );
    for i = 1 : totalFrequencyBins
%     for i = 300 : 300
%         y = y + amplitude(i) * cos( 2*pi * frequency(i) * time);
        y = y + amplitude(i) * cos( 2*pi * frequency(i) * time + phase(i) );
    end
    signal=y;

    
% figure;
% subplot( 211 )
% plot( time, signal );
% xlabel( 'Time [s]' );
% title( 'Time signal' );
% 
% [pxx, f] = periodogram( signal,[],length(signal),samplingFrequency);
% 
% subplot( 212 )
% % periodogram( signal )
% % plot( w/pi*samplingFrequency/2, 10*log10(pxx) );
% plot( f(1:totalFrequencyBins), 10*log10(pxx(1:totalFrequencyBins)) );
% % plot( w/pi*samplingFrequency/2, pxx );
% xlabel( 'Frequency [Hz]' )
% title( 'Periodogram' )
