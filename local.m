function [local_time] = local(UTC, long)
% This function calculates the local time given longitude
% and universal time.
local_time = UTC + (long/360).*(24*60*60);
end

