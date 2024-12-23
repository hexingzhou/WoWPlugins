--[[
- The value of type follows: https://warcraft.wiki.gg/wiki/Enum.PowerType.
--]]
local env = aura_env or {}

env.info = {
    power = {
        type = -1,
        unmodified = false,
        per = 0,
    },
    show = {
        func = nil,
        dynamic = false, -- Set true, if using form
        value = 0, -- 1 for show, -1 for hide, 0 for default
        form = {
            [0] = {
                value = 0,
            },
        },
        spec = {
            [0] = {
                value = 0,
                form = {
                    [0] = {
                        value = 0,
                    },
                },
            },
        },
    },
}
