--[[
- Frames
--]]
function(states, event, ...)
    if HWA and HWA.scanCurrentRanges then
        aura_env.time = aura_env.time or {}

        local key = "RANGE"
        local time = aura_env.time[key] or 0

        local now = GetTime()
        if now - time > 0.2 then
            HWA.scanCurrentRanges()
            aura_env.time[key] = now
        end
    end
end
