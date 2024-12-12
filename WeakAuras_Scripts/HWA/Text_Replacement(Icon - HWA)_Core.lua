function()
    if aura_env.state then
        local cooldown = aura_env.state.subExpirationTime - GetTime()
        if cooldown < 0 then
            cooldown = 0
        end
        local stacks = aura_env.state.subStacks

        return cooldown, stacks
    end
end
