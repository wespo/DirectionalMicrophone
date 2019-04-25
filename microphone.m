classdef microphone < handle
    properties
        x
        y
        z
        fs
    end
    properties (Access = private)
        audioData
    end
    properties (Dependent = true)
        audio
        pos
        time
    end
    methods
        function obj = microphone(x,y,z,fs)
            if nargin < 4
                obj.fs = 44100;
            else
                obj.fs = fs;
            end
            if nargin < 3
                obj.z = 0;
            else
                obj.z = z;
            end
            if nargin < 2
                obj.y = 0;
            else
                obj.y = y;
            end
            if nargin < 1
                obj.x = 0;
            else
                obj.x = x;
            end
        end
        function audio = get.audio(obj)
            audio = obj.audioData;
        end
        function set.audio(obj, audioData)
            %adds new audio data to recieved audio. Starts at index zero.
            sizeOld = size(obj.audioData);
            sizeNew = size(audioData);
            newData = zeros(max([sizeOld; sizeNew]));
            newData(1:size(audioData,1),1:size(audioData,2)) = audioData;
            newData(1:size(obj.audioData,1),1:size(obj.audioData,2)) = newData(1:size(obj.audioData,1),1:size(obj.audioData,2)) + obj.audioData;
            obj.audioData = newData;
        end
        function clearAudio(obj)
            obj.audioData = [];
        end
        function loc = get.pos(obj)
            loc = [obj.x, obj.y, obj.z];
        end
        function timeData = get.time(obj)
            timeData = [0:length(obj.audioData)-1]./obj.fs;
        end
        function recieveWaveform(obj, ws)
            %takes a wavesource, and adds a delay to match the time of
            %flight of the distance between the two
            dof = norm((ws.pos - obj.pos));
            thetaOfFlight = 2*pi*dof*ws.wf.f/343.6;
            obj.audio = ws.wf.getDelayedWaveform(thetaOfFlight);
        end
    end
    
end