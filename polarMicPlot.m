figure; 
polaraxes;
space = logspace(1,3,10);
for f = space
    wf = wave(f,0, 44100, 1);
    m = [microphone(0,-1/44100*343.6/2,0) microphone(0,1/44100*343.6/2,0)];

    polarPattern = zeros(1,360);
    for theta = 1:360
        ws = waveSource(cos(pi/180*theta),sin(pi/180*theta),0, wf);

        m(1).clearAudio;
        m(2).clearAudio;
        m(1).recieveWaveform(ws);
        m(2).recieveWaveform(ws);

        diffsig = (m(1).audio-m(2).audio);% .* (m(1).audio+m(2).audio);
        sampMag = max(diffsig);%max(m(1).audio .* (m(1).audio - 2*m(2).audio))
        polarPattern(theta) = sampMag;
    end

    polarplot(pi/180*[1:360], mag2db(1e6*polarPattern)./103);
    hold on;
end
legend(num2str(space.'));
%figure; hold on; subplot(3,1,1); plot(m(1).audio); xlim([1,100]); subplot(3,1,2); plot(m(2).audio); xlim([1,100]); subplot(3,1,3); plot(m(1).audio - m(2).audio); xlim([1,100])