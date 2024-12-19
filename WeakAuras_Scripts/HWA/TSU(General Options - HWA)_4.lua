--[[
- Frames
--]]
function(states, event, ...)
    local H = HWA
    local env = aura_env or {}

    if not H then
        return
    end

    env.time = env.time or {}

    local key = "RANGE"
    local time = env.time[key] or 0

    local now = GetTime()
    if now - time > 0.2 then
        H.scanCurrentRanges()
        env.time[key] = now
    end
end
