--[[
-- Frames
--]]
function()
    if aura_env.state then
        local cooldown = aura_env.state.subExpirationTime or 0
        if cooldown > 0 then
            cooldown = cooldown - GetTime()
            if cooldown < -0.5 then
                if HWA and HWA.initCurrentAuras then
                    HWA.initCurrentAuras()
                end
            end
            if cooldown < 0 then
                cooldown = 0
            end
        end
        local stacks = aura_env.state.subStacks or 0

        return cooldown, stacks
    end
end
