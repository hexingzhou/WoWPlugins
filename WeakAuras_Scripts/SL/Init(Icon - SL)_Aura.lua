aura_env.aura = {
    configs = {
        {
            id = 0, -- Key for auraInstanceID
            unit_targets = {

            },
            source_units = {

            },
            group = 0
        }
    },
    strategies = {
        -- Use groupID as key.
        [0] = {
            priority = 0,
            result = nil --[[ function(auras)
                local aura = auras[1]
                local stacks = 0
                if aura.charges > 1 then
                    states = aura.charges
                end
                return {
                    autoHide = true,
                    progressType = "timed",
                    duration = aura.duration,
                    expirationTime = aura.expirationTime,
                    stacks = stacks
                }
            end ]]
        }
    }
}