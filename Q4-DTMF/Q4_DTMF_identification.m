data1 = load('DTMF1.mat');
data2 = load('DTMF2.mat');

% Average out the stereo channels
% Choose data1 or data2 here
col1 = data1.acqData(:,1);
col2 = data1.acqData(:,2);
combinedCol = cat(3, col1, col2);
meanData = mean(combinedCol, 3);

% Based on the sampling rate, we know the dt between each data point
dt = 1/Fsampling;
N = length(meanData);
t = 0 + (0:N-1)*dt;

figure;
subplot(4, 1, 1);
plot(t, meanData);
title('Input data');
xlabel('Time (s)');

% Take the fourier transform to prepare for noise filtering
spectrum = fft(meanData);
Fsampling = 16000;
N = length(spectrum);
freq = horzcat(-linspace(0,N/2,N/2 )*Fsampling/N,linspace(N/2 + 1 ,0,N/2 + 1)*Fsampling/N);

subplot(4, 1, 2);
stem(freq, spectrum);
title('Spectrum')
xlabel('Frequency (Hz)');

% Create bandpass filter to remove noise
filterVal = zeros(length(spectrum), 1);
filterFreq = freq.';
for i = 1:length(spectrum)
    if ((abs(filterFreq(i)) > 685) && (abs(filterFreq(i)) < 1495))
        filterVal(i) = 1;
    end
end

% Remove noise by applying bandpass filter to spectrum
cleanedSpectrum = spectrum .* filterVal;

subplot(4, 1, 3);
stem(freq, cleanedSpectrum);
title('Filtered spectrum');
xlabel('Frequency (Hz)');

% Inverse FT to get back to time domain
xt = ifft(cleanedSpectrum);

subplot(4, 1, 4);
plot(t, xt);
title('Filtered input');
xlabel('Time (s)');

% Iterate through xt to get start indices for each key press
recording = false;
time = 0;
tones = []; % store start indices for key presses

for i = 1:length(xt)
    if recording == false && abs(xt(i)) > 0.05 
        recording = true;
        tones = [tones, i];
    elseif recording == true && time >= 4000
        recording = false;
        time = 0;
    elseif recording == true
        time = time + 1;
    end
end
         
% Length of tones is around 3200 samples (0.2s / dt)
% Take FT of the sections of our data for each key press
spectrums = []; % store spectrum of each key press data interval

for i = 1:length(tones)
    signal = xt(tones(i):(tones(i)+3200));
    spectrums = [spectrums, fft(signal)]; 
end

% Now with the FTs, we can isolate which frequencies appear in the tone, and
% match that with the key given in the question.
N = length(spectrums(:, 2));
freq = horzcat(-linspace(0,N/2,N/2 )*Fsampling/N,linspace(N/2 + 1 ,0,N/2 + 1)*Fsampling/N);

figure;

beeps = [697, 770, 852, 941];
boops = [1209, 1336, 1477];

keys = []; % store key press sequence
range = 20; % real world data is imperfect, so use +/- range for acceptable values

for j = 1:length(spectrums(1,:)) 
    % iterate through the spectrums of the key presses we isolated to find
    % frequencies and map to key tone
    tone = [abs(freq(:)), abs(spectrums(:, j))];
    beep = 0;
    boop = 0;
    for i = 1:length(tone)
        if tone(i,1) < 1000 && tone(i,2) > 15 
            beep = tone(i,1);
        elseif tone(i,1) > 1000 && tone(i,2) > 15 
            boop = tone(i,1);
        end
    end

    if 1209-range < boop && boop < 1209+range
        if 697-range < beep && beep < 697+range
            keys = [keys, '1'];
        end
        if 770-range < beep && beep < 770+range
            keys = [keys, '4'];
        end
        if 852-range < beep && beep < 852+range
            keys = [keys, '7'];
        end
        if 941-range < beep && beep < 941+range
            keys = [keys, '*'];
        end
    end
    if 1336-range < boop && boop < 1336+range
        if 697-range < beep && beep < 697+range
            keys = [keys, '2'];
        end
        if 770-range < beep && beep < 770+range
            keys = [keys, '5'];
        end
        if 852-range < beep && beep < 852+range
            keys = [keys, '8'];
        end
        if 941-range < beep && beep < 941+range
            keys = [keys, '0'];
        end
    end
    if 1477-range < boop && boop < 1477+range
        if 697-range < beep && beep < 697+range
            keys = [keys, '3'];
        end
        if 770-range < beep && beep < 770+range
            keys = [keys, '6'];
        end
        if 852-range < beep && beep < 852+range
            keys = [keys, '9'];
        end
        if 941-range < beep && beep < 941+range
            keys = [keys, '#'];
        end
    end
    
    subplot(6, 2, j);
    stem(abs(freq), abs(spectrums(:, j)));
    title(j);
    xlabel('Frequency (Hz)');
end
