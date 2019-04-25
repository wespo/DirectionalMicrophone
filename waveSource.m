classdef waveSource < handle
    properties
        wf
        x
        y
        z
    end
    properties (Dependent = true)
        pos
    end
    methods
        function obj = waveSource(x, y, z, wf)
            % Accepts x, y, z (waveform 3D coordinates) and wf, a waveform
            % object.
            if nargin < 4
                obj.wf = wave();
            else
                obj.wf = wf;
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
        function loc = get.pos(obj)
            loc = [obj.x, obj.y, obj.z];
        end
    end
end