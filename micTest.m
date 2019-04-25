wf = wave(1000,0, 44100, 1);
ws = waveSource(1,0.1,0, wf);

wf = wave(1000,0, 44100, 1);
ws = waveSource(1,0.2,0, wf);

m = [microphone(0,0,0) microphone(0,0.2,0)];
m(1).clearAudio
m(2).clearAudio

m(1).recieveWaveform(ws)
m(2).recieveWaveform(ws)

figure; hold on; subplot(3,1,1); plot(m(1).audio); xlim([1,100]); subplot(3,1,2); plot(m(2).audio); xlim([1,100]); subplot(3,1,3); plot(m(1).audio - m(2).audio); xlim([1,100])