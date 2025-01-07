local env = aura_env or {}

env.info = {
    spell = {
        id = 0, -- spellID
        precise = false,
        pet = false,
        gcd = false,
        range = false,
        health = {
            func = nil,
        },
    },
    strategy = {
        {
            func = nil,
        },
    },
    show = {
        func = nil,
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
    priority = {
        value = 0,
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
