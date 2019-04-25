%simulated microphone array
m = [microphone(0,0,0) microphone(0,0.2,0)];

w1 = wave(400, 0, 44100, 1);
w2 = wave(650, 0, 44100, 1);
w3 = wave(1000,0, 44100, 1);

w = [waveSource(2,1,0, w1),waveSource(-2,1,0, w2), waveSource(0,-2,0, w3)];

for ws = waveSource(0,3,0, w1)
    for ms = m
        ms.recieveWaveform(ws);
    end
end

figure;
plot(m(1).time(1:441), m(1).audio(1:441)); 
hold on; 
plot(m(2).time(1:441), m(2).audio(1:441));
legend('microphone 1','microphone 2');