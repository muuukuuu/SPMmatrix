function plt3cmPSD(fs,wave_data)

figure;
pws(1,:) = psd(detrend(wave_data(1,:)).*hanning(length(wave_data(1,:)))');
pws(2,:) = psd(detrend(wave_data(3,:)).*hanning(length(wave_data(2,:)))');
pws(3,:) = psd(detrend(wave_data(3,:)).*hanning(length(wave_data(3,:)))');
% pws(1,:) = fft(detrend(wave_data(1,:)).*hanning(length(wave_data(1,:)))');
% pws(2,:) = fft(detrend(wave_data(3,:)).*hanning(length(wave_data(2,:)))');
% pws(3,:) = fft(detrend(wave_data(3,:)).*hanning(length(wave_data(3,:)))');
F=(1:length(pws(1,:)))*(fs/length(pws(1,:))/2);

subplot(3,1,1)
plot(F,10*log(pws(1,:)));hold on;
xlabel('Frequency(Hz)'); ylabel('Power (dB)');

subplot(3,1,2)
plot(F,10*log(pws(2,:)));hold on;
xlabel('Frequency(Hz)'); ylabel('Power (dB)');

subplot(3,1,3)
plot(F,10*log(pws(3,:)));hold on;
xlabel('Frequency(Hz)'); ylabel('Power (dB)');
    
set(gcf,'Position',[159   0   860*0.65   771*0.9]) % By Hotta Dec.18
    
