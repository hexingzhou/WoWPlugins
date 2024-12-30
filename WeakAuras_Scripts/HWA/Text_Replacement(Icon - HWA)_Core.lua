--[[
-- Frames
--]]
function()
    local env = aura_env or {}
    
    if env.state then
        local cooldown = env.state.subExpirationTime or 0
        if cooldown > 0 then
            cooldown = cooldown - GetTime()
            if cooldown < 0 then
                cooldown = 0
            end
        end
        local stacks = env.state.subStacks
        if stacks == 0 then
            stacks = nil
        end

        return cooldown, stacks
    end
end
