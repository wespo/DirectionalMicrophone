classdef wave < handle
    properties
        f
        theta
        fs
        duration
    end
    properties (Dependent = true)
        waveform
        time
    end
    
    methods
        function obj = wave(f,theta,fs,duration)
            % Accepts f (output frequency), fs (sample frequency) and
            % duration (waveform run time).
            if nargin < 4
                obj.duration = 1;
            else
                obj.duration = duration;
            end
            if nargin < 3
                obj.fs = 44100;
            else
                obj.fs = fs;
            end
            if nargin < 1
                obj.theta = 0;
            else
                obj.theta = theta;
            end
            if nargin < 1
                obj.f = 1000;
            else
                obj.f = f;
            end
        end
        function waveData = getDelayedWaveform(obj, theta)
            oldTheta = obj.theta;
            obj.theta = theta;
            waveData = obj.waveform;
            obj.theta = oldTheta;
        end
        function waveData = get.waveform(obj)
            t = obj.time;
            waveData=sin(2*pi*obj.f*t + obj.theta);
        end
        function timeData = get.time(obj)
            ts = 1/obj.fs;
            timeData = 0:ts:obj.duration;
        end
    end
end