function b=MakeBPwhiteNoise(fs,freq_C)
sampling=fs;                        % Sampling freq
n=5;                                % Parameter setting for filter
fm = freq_C;                        % Center Freq
f1= fm/sqrt(2)                      % lower freq
f2= fm*sqrt(2)                      % higher freq
oct_band= [f1 f2]/(sampling/2);     % Bandpath
b = fir1(n,oct_band,'bandpass');    % Filter
