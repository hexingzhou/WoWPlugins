--[[
-- CLASS identifier follows https://warcraft.wiki.gg/wiki/API_UnitClass.
-- Include:
-- 1. WARRIOR
-- 2. PALADIN
-- 3. HUNTER
-- 4. ROGUE
-- 5. PRIEST
-- 6. DEATHKNIGHT
-- 7. SHAMAN
-- 8. MAGE
-- 9. WARLOCK
-- 10. MONK
-- 11. DRUID
-- 12. DEMONHUNTER
-- 13. EVOKER


-- FORM follows https://warcraft.wiki.gg/wiki/API_GetShapeshiftFormID.

ALL
- nil = humanoid form

DRUID
- Aquatic Form - 4
- Bear Form - 5 (BEAR_FORM constant)
- Cat Form - 1 (CAT_FORM constant)
- Flight Form - 29
- Moonkin Form - 31 - 35 (MOONKIN_FORM constant) (different races seem to have different numbers)
- Swift Flight Form - 27
- Travel Form - 3
- Tree of Life - 2
- Treant Form - 36

MONK
- Stance of the Fierce Tiger - 24
- Stance of the Sturdy Ox - 23
- Stance of the Wise Serpent - 20

ROGUE
- Stealth - 30

SHAMAN
- Ghost Wolf - 16

WARLOCK
- Metamorphosis - 22

WARRIOR
- Battle Stance - 17
- Berserker Stance - 19
- Defensive Stance - 18


-- SPEC follows https://warcraft.wiki.gg/wiki/SpecializationID.

                Spec 1              Spec 2              Spec 3              Spec 4
DEATHKNIGHT     250  Blood          251  Frost          252  Unholy
DEMONHUNTER     577  Havoc          581  Vengeance
DRUID           102  Balance        103  Feral          104  Guardian       105  Restoration
EVOKER          1467 Devastation    1468 Preservation   1473 Augmentation
HUNTER          253  Beast Mastery  254  Marksmanship   255  Survival
MAGE            62   Arcane         63   Fire           64   Frost
MONK            268  Brewmaster     270  Mistweaver     269  Windwalker
PALADIN         65   Holy           66   Protection     70   Retribution
PRIEST          256  Discipline     257  Holy           258  Shadow
ROGUE           259  Assassination  260  Outlaw         261  Subtlety
SHAMAN          262  Elemental      263  Enhancement    264  Restoration
WARLOCK         265  Affliction     266  Demonology     267  Destruction
WARRIOR         71   Arms           72   Fury           73   Protection
--]]

---------------- Config ------------------
-- Default config is set in the order as core, resouece, dynamic effects, and maintenance.
-- Control in order: read from 1 to 8, and the higher can override the lower with the same key if exists.
-- root
--  |________________________________
--  |1      |       |               |
-- core    form    group           spec
--          |       |________       |________________
--          |2      |3      |       |5      |       |
--         core    core    form    core    form    group
--                          |               |       |________
--                          |4              |6      |7      |
--                         core            core    core    form
--                                                          |
--                                                          |8
--                                                         core
local default = {
    core = {
        x_offset = 0,
        y_offset = 21,
        width = 43,
        height = 43,
        horizontal_spacing = 1,
        vertical_spacing = 3,
        max_icon_size_pl = 9,
        direction = 2, -- 1 for up, 2 for down
        sub_width = 35,
        sub_height = 35,
        sub_horizontal_spacing = 1,
        sub_vertical_spacing = 3,
        max_sub_icon_size_pl = 11,
        min_sub_icon_size_pl = 3,
        sub_spacing = 3,
    },
    -- resource config is used for single resource, such as power of Mana. So y_offset may be set by progress bar self.
    resource = {
        x_offset = 0,
        y_offset = 0,
        total_width = 395,
        height = 7,
        horizontal_spacing = 3,
    },
    dynamic_effects = {
        x_offset = -198,
        y_offset = 105,
        width = 43,
        height = 43,
        horizontal_spacing = 1,
        vertical_spacing = 3,
        max_icon_size_pl = 9,
        direction = 1,
        grow = 1, -- 1 for left to right, 2 for mid, 3 for right to left
    },
    maintenance = {
        x_offset = 0,
        y_offset = 634,
        width = 43,
        height = 43,
        horizontal_spacing = 1,
        vertical_spacing = 3,
        max_icon_size_pl = 14,
        direction = 1,
    },
    form = {
        -- Use ShapeshiftFormID to support different form.
        [1] = { -- For Druid Cat Form
            core = {},
        },
        [5] = { -- For Druid Bear Form
            core = {},
        },
    },
    group = {
        [1] = {
            core = {},
            form = {},
        },
    },
    spec = {
        -- Use SpecializationID to support different duty.
        [65] = { -- For Paladin Holy
            core = {
                max_icon_size_pl = 14,
                max_sub_icon_size_pl = 17,
            },
            resource = {
                total_width = 615,
            },
            dynamic_effects = {
                x_offset = -308,
                max_icon_size_pl = 14,
            },
            group = {
                [5] = {
                    core = {
                        y_offset = 73,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 149,
                    },
                },
                [20] = {
                    core = {
                        y_offset = 73,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 149,
                    },
                },
                [30] = {
                    core = {
                        y_offset = 73,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 149,
                    },
                },
            },
        },
        [105] = { -- For Druid Restoration
            core = {
                max_icon_size_pl = 14,
                max_sub_icon_size_pl = 17,
            },
            resource = {
                total_width = 615,
            },
            dynamic_effects = {
                x_offset = -308,
                max_icon_size_pl = 14,
            },
            form = {
                [1] = {
                    core = {},
                },
            },
            group = {
                [5] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                    form = {
                        [1] = {
                            core = {
                                y_offset = 83,
                            },
                            dynamic_effects = {
                                y_offset = 159,
                            },
                        },
                        [5] = {
                            core = {
                                y_offset = 83,
                            },
                            dynamic_effects = {
                                y_offset = 159,
                            },
                        },
                    },
                },
                [20] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                    form = {
                        [1] = {
                            core = {
                                y_offset = 83,
                            },
                            dynamic_effects = {
                                y_offset = 159,
                            },
                        },
                        [5] = {
                            core = {
                                y_offset = 83,
                            },
                            dynamic_effects = {
                                y_offset = 159,
                            },
                        },
                    },
                },
                [30] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                    form = {
                        [1] = {
                            core = {
                                y_offset = 83,
                            },
                            dynamic_effects = {
                                y_offset = 159,
                            },
                        },
                        [5] = {
                            core = {
                                y_offset = 83,
                            },
                            dynamic_effects = {
                                y_offset = 159,
                            },
                        },
                    },
                },
            },
        },
        [256] = { -- For Priest Discipline
            core = {
                max_icon_size_pl = 14,
                max_sub_icon_size_pl = 17,
            },
            resource = {
                total_width = 615,
            },
            dynamic_effects = {
                x_offset = -308,
                max_icon_size_pl = 14,
            },
            group = {
                [5] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                },
                [20] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                },
                [30] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                },
            },
        },
        [257] = { -- For Priest Holy
            core = {
                max_icon_size_pl = 14,
                max_sub_icon_size_pl = 17,
            },
            resource = {
                total_width = 615,
            },
            dynamic_effects = {
                x_offset = -308,
                max_icon_size_pl = 14,
            },
            group = {
                [5] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                },
                [20] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                },
                [30] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                },
            },
        },
        [264] = { -- For Shaman Restoration
            core = {
                max_icon_size_pl = 14,
                max_sub_icon_size_pl = 17,
            },
            resource = {
                total_width = 615,
            },
            dynamic_effects = {
                x_offset = -308,
                max_icon_size_pl = 14,
            },
            group = {
                [5] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                },
                [20] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                },
                [30] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                },
            },
        },
        [270] = { -- For Monk Mistweaver
            core = {
                max_icon_size_pl = 14,
                max_sub_icon_size_pl = 17,
            },
            resource = {
                total_width = 615,
            },
            dynamic_effects = {
                x_offset = -308,
                max_icon_size_pl = 14,
            },
            group = {
                [5] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                },
                [20] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                },
                [30] = {
                    core = {
                        y_offset = 63,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 139,
                    },
                },
            },
        },
        [1468] = { -- For Evoker Preservation
            core = {
                max_icon_size_pl = 14,
                max_sub_icon_size_pl = 17,
            },
            resource = {
                total_width = 615,
            },
            dynamic_effects = {
                x_offset = -308,
                max_icon_size_pl = 14,
            },
            group = {
                [5] = {
                    core = {
                        y_offset = 73,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 149,
                    },
                },
                [20] = {
                    core = {
                        y_offset = 73,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 149,
                    },
                },
                [30] = {
                    core = {
                        y_offset = 73,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 149,
                    },
                },
            },
        },
        [1473] = { -- For Evoker Augmentation
            core = {
                max_icon_size_pl = 14,
                max_sub_icon_size_pl = 17,
            },
            resource = {
                total_width = 615,
            },
            dynamic_effects = {
                x_offset = -308,
                max_icon_size_pl = 14,
            },
            group = {
                [5] = {
                    core = {
                        y_offset = 73,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 149,
                    },
                },
                [20] = {
                    core = {
                        y_offset = 73,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 149,
                    },
                },
                [30] = {
                    core = {
                        y_offset = 73,
                        width = 35,
                        height = 35,
                        max_icon_size_pl = 17,
                        direction = 1,
                    },
                    dynamic_effects = {
                        y_offset = 149,
                    },
                },
            },
        },
    },
}
---------------- Config ------------------

---------------- Global ------------------
HWA = HWA or {}

local function tcontains(t, v)
    if not t then
        return false
    end
    if not v then
        return true
    end
    for _, value in ipairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

local function tclone(t)
    local tr = {}

    if t then
        for k, v in pairs(t) do
            if "table" == type(v) then
                v = tclone(v)
            end

            if "string" == type(k) then
                tr[k] = v
            else
                tinsert(tr, v)
            end
        end
    end

    return tr
end

local function tmerge(...)
    local ts = { ... }
    local tr = tclone(ts[1])
    local t

    for i = 2, #ts do
        t = ts[i] or {}

        for k, v in pairs(t) do
            if "table" == type(v) then
                v = tclone(v)
                if tr[k] and #tr[k] == 0 then
                    tr[k] = tmerge(tr[k], v)
                else
                    tr[k] = v
                end
            else
                tr[k] = v
            end
        end
    end

    return tr
end

local function createFunctionCache()
    local cache = {
        funcs = setmetatable({}, { __mode = "v" }),
    }
    cache.load = function(self, string, silent)
        if self.funcs[string] then
            return self.funcs[string]
        else
            local loadedFunction, errorString = loadstring(string, firstLine(string))
            if errorString then
                if not silent then
                    print(errorString)
                end
                return nil, errorString
            elseif loadedFunction then
                --- @cast loadedFunction -nil
                local success, func = pcall(assert(loadedFunction))
                if success then
                    self.funcs[string] = func
                    return func
                end
            end
        end
    end
    return cache
end
local function_cache_custom = createFunctionCache()
---------------- Global ------------------

---------------- Base ------------------
local config = nil
local env = aura_env
local bgMaxPlayers = {}
local H = HWA

env.parent = WeakAuras.GetData(env.id).parent

for i = 1, GetNumBattlegroundTypes() do
    local _, _, _, _, _, _, bgInstanceID, maxPlayers = GetBattlegroundInfo(i)
    bgMaxPlayers[bgInstanceID] = maxPlayers
end

H.configs = H.configs or {}
H.configs["GENERAL"] = env.config

H.bit = {
    tobit = function(x)
        x = x % (2 ^ 32)
        if x >= 2 ^ 31 then
            return x - 2 ^ 32
        end
        return x
    end,
    tohex = function(x, n)
        if n == nil then
            n = 8
        elseif n < 0 then
            n = -n
            x = x % (2 ^ (n * 4))
            x = string.format("%0" .. n .. "X", x)
            return x
        end
        x = x % (2 ^ (n * 4))
        x = string.format("%0" .. n .. "x", x)
        return x
    end,
    bnot = function(x)
        x = x % (2 ^ 32)
        local output = 0
        for i = 0, 31 do
            if x % 2 == 0 then
                output = output + 2 ^ i
            end
            x = math.floor(x / 2)
        end
        if output >= 2 ^ 31 then
            output = output - 2 ^ 32
        end
        return output
    end,
    bor = function(...)
        local output = 0
        local bits = {}
        for i = 1, select("#", ...) do
            local x = select(i, ...)
            x = x % (2 ^ 32)
            for i = 1, 32 do
                if x % 2 ~= 0 and bits[i] == nil then
                    bits[i] = true
                    output = output + 2 ^ (i - 1)
                end
                x = math.floor(x / 2)
            end
        end
        if output >= 2 ^ 31 then
            output = output - 2 ^ 32
        end
        return output
    end,
    band = function(...)
        local output = 2 ^ 32 - 1
        local bits = {}
        for i = 1, select("#", ...) do
            local x = select(i, ...)
            x = x % (2 ^ 32)
            for i = 1, 32 do
                if x % 2 == 0 and bits[i] == nil then
                    bits[i] = true
                    output = output - 2 ^ (i - 1)
                end
                x = math.floor(x / 2)
            end
        end
        if output >= 2 ^ 31 then
            output = output - 2 ^ 32
        end
        return output
    end,
    bxor = function(...)
        local bits = {}
        for i = 1, select("#", ...) do
            local x = select(i, ...)
            x = x % (2 ^ 32)
            for i = 1, 32 do
                if x % 2 ~= 0 then
                    bits[i] = not bits[i]
                end
                x = math.floor(x / 2)
            end
        end
        local output = 0
        for i = 1, 32 do
            if bits[i] == true then
                output = output + 2 ^ (i - 1)
            end
        end
        if output >= 2 ^ 31 then
            output = output - 2 ^ 32
        end
        return output
    end,
    lshift = function(x, n)
        x = x % (2 ^ 32)
        n = n % 32
        x = x * (2 ^ n)
        x = x % (2 ^ 32)
        if x >= 2 ^ 31 then
            x = x - 2 ^ 32
        end
        return x
    end,
    rshift = function(x, n)
        x = x % (2 ^ 32)
        n = n % 32
        for i = 1, n do
            x = math.floor(x / 2)
        end
        if x >= 2 ^ 31 then
            x = x - 2 ^ 32
        end
        return x
    end,
    arshift = function(x, n)
        x = x % (2 ^ 32)
        n = n % 32
        local extension = 0
        if x >= 2 ^ 31 then
            extension = 2 ^ 31
        end
        for i = 1, n do
            x = math.floor(x / 2) + extension
        end
        if x >= 2 ^ 31 then
            x = x - 2 ^ 32
        end
        return x
    end,
    rol = function(x, n)
        x = x % (2 ^ 32)
        n = n % 32
        for i = 1, n do
            x = x * 2
            if x >= 2 ^ 32 then
                x = x % (2 ^ 32) + 1
            end
        end
        if x >= 2 ^ 31 then
            x = x - 2 ^ 32
        end
        return x
    end,
    ror = function(x, n)
        x = x % (2 ^ 32)
        n = n % 32
        for i = 1, n do
            local msb = 0
            if x % 2 ~= 0 then
                msb = 2 ^ 31
            end
            x = math.floor(x / 2) + msb
        end
        if x >= 2 ^ 31 then
            x = x - 2 ^ 32
        end
        return x
    end,
    bswap = function(x)
        x = x % (2 ^ 32)
        local b1 = math.floor(x / 0x1000000)
        local b2 = math.floor(x / 0x10000) % 0x100
        local b3 = math.floor(x / 0x100) % 0x100
        local b4 = x % 0x100
        x = b4 * 0x1000000 + b3 * 0x10000 + b2 * 0x100 + b1
        if x >= 2 ^ 31 then
            x = x - 2 ^ 32
        end
        return x
    end,
}

local function loadFunction(str)
    return function_cache_custom:load(str)
end

-- 1: solo
-- 5: party
-- 20: mythic raid
-- 30: normal raid
-- 40: outdoor raid
local function getLocalGroupID()
    local inInstance, instanceType = IsInInstance()

    if instanceType == "pvp" then
        local _, _, _, _, _, _, isDynamic, instanceID, instanceGroupSize, lfgDungeonID = GetInstanceInfo()
        if bgMaxPlayers[lfgDungeonID] then
            if bgMaxPlayers[lfgDungeonID] <= 15 then
                return 30
            else
                return 40
            end
        else
            return 30
        end
    elseif instanceType == "arena" then
        return 5
    else -- party or raid
        if IsInRaid() then
            local difficultyID = select(3, GetInstanceInfo())
            if difficultyID == 16 then
                return 20
            elseif inInstance then
                return 30
            else
                return 40
            end
        elseif IsInGroup() then
            return 5
        else
            return 1
        end
    end
end

local function getStateShow(config)
    if not config then
        return true
    end

    local specID = env.specID or 0
    local formID = env.formID or 0

    local value = config.value or 0

    if config.form then
        local show = config.form[formID] and config.form[formID].value or 0
        if show ~= 0 then
            value = show
        end
    end

    if config.spec then
        local sConfig = config.spec[specID]
        if sConfig then
            local show = sConfig.value or 0
            if show ~= 0 then
                value = show
            end
            if sConfig.form then
                show = sConfig.form[formID] and sConfig.form[formID].value or 0
                if show ~= 0 then
                    value = show
                end
            end
        end
    end
    if value < 0 then
        return false
    else
        return true
    end
end

-- The init value is used to trigger group grow.
local function getStateInit()
    return (env.specID or 0) * 10000 + (env.groupID or 0) * 100 + (env.formID or 0)
end

-- The priority value is used to trigger group sort.
local function getStatePriority(config)
    if not config then
        return 0
    end

    local specID = env.specID or 0
    local formID = env.formID or 0

    local value = config.value or 0

    if config.form then
        local priority = config.form[formID] and config.form[formID].value or 0
        if priority ~= 0 then
            value = priority
        end
    end

    if config.spec then
        local sConfig = config.spec[specID]
        if sConfig then
            local priority = sConfig.value or 0
            if priority ~= 0 then
                value = priority
            end
            if sConfig.form then
                priority = sConfig.form[formID] and sConfig.form[formID].value or 0
                if priority ~= 0 then
                    value = priority
                end
            end
        end
    end

    return value
end

local function updateEnv()
    local update = false
    local specID = 0
    local spec = GetSpecialization()
    if spec then
        specID = GetSpecializationInfo(spec) or 0
    end
    if env.specID ~= specID then
        env.specID = specID
        update = true
    end
    local groupID = getLocalGroupID() or 0
    if env.groupID ~= groupID then
        env.groupID = groupID
        update = true
    end
    local formID = GetShapeshiftFormID() or 0
    if env.formID ~= formID then
        env.formID = formID
        update = true
    end

    return update
end

function H.getLocalConfig(config, key, specID, groupID, formID)
    if not config then
        return {}
    end
    local c = config or {}
    local f = c.form and c.form[formID] or {}
    local g = c.group and c.group[groupID] or {}
    local gf = g.form and g.form[formID] or {}
    local s = c.spec and c.spec[specID] or {}
    local sf = s.form and s.form[formID] or {}
    local sg = s.group and s.group[groupID] or {}
    local sgf = sg.form and sg.form[formID] or {}

    return tmerge(
        c[key] or {},
        f[key] or {},
        g[key] or {},
        gf[key] or {},
        s[key] or {},
        sf[key] or {},
        sg[key] or {},
        sgf[key] or {}
    )
end

function H.getConfig(key, class)
    if not key then
        config = nil
        return
    end

    local specID = env.specID or 0
    local groupID = env.groupID or 0
    local formID = env.formID or 0

    config = config or {}
    config[specID] = config[specID] or {}
    config[specID][groupID] = config[specID][groupID] or {}
    config[specID][groupID][formID] = config[specID][groupID][formID] or {}
    if not config[specID][groupID][formID][key] or WeakAuras.IsOptionsOpen() then
        config[specID][groupID][formID][key] = H.getLocalConfig(default, key, specID, groupID, formID)
        config[specID][groupID][formID][key] = tmerge(
            config[specID][groupID][formID][key],
            H.getLocalConfig(H.configs["GENERAL"], key, specID, groupID, formID)
        )
        if class then
            config[specID][groupID][formID][key] = tmerge(
                config[specID][groupID][formID][key],
                H.getLocalConfig(H.configs[class], key, specID, groupID, formID)
            )
        end
    end

    return config[specID][groupID][formID][key]
end
---------------- Base ------------------

---------------- Range ------------------
local currentRanges = {}

local function getCurrentRange(id)
    if currentRanges[id] then
        return currentRanges[id].range or {}
    end
    return {}
end

local function handleCurrentRange(range, unitTarget, id)
    if currentRanges[id] then
        currentRanges[id].range = currentRanges[id].range or {}

        local r = currentRanges[id].range[unitTarget]
        if r == nil then
            r = true
        end

        currentRanges[id].range[unitTarget] = range

        if r ~= range then
            return true
        end
    end
    return false
end

local function scanCurrentRange(unitTarget, id)
    local cache = currentRanges[id]
    if not cache then
        return true
    end

    local spell = id
    local spellInfo = C_Spell.GetSpellInfo(spell)
    if spellInfo then
        if not cache.precise and spellInfo.name then
            spell = spellInfo.name
            spellInfo = C_Spell.GetSpellInfo(spell)
        end
    end

    if not spellInfo then
        return true
    end

    local range = C_Spell.IsSpellInRange(spell, unitTarget)
    if range == nil then
        return true
    end
    return range
end

local function watchSpellRange(id, precise, unitTargets)
    if not id then
        return
    end
    currentRanges[id] = {}
    currentRanges[id].precise = precise or false
    currentRanges[id].unitTargets = unitTargets or {}

    for _, unitTarget in ipairs(currentRanges[id].unitTargets) do
        handleCurrentRange(scanCurrentRange(unitTarget, id), unitTarget, id)
    end
end

function H.scanCurrentRanges()
    local changed = {}
    for id, cache in pairs(currentRanges) do
        for _, unitTarget in ipairs(cache.unitTargets) do
            if handleCurrentRange(scanCurrentRange(unitTarget, id), unitTarget, id) then
                -- Changed.
                changed[id] = cache.range or {}
            end
        end
    end
    if next(changed) then
        WeakAuras.ScanEvents("HWA_SPELL_IN_RANGE_UPDATE", changed)
    end
end
---------------- Range ------------------

---------------- Health ------------------
local currentHealthes = {}

local function getCurrentHealth(id)
    return currentHealthes.spells and currentHealthes.spells[id] and currentHealthes.spells[id].state or {}
end

local function handleCurrentHealth(id)
    if currentHealthes.spells and currentHealthes.spells[id] then
        local func = currentHealthes.spells[id].func
        if func then
            local changed, state = func(currentHealthes.healthes, currentHealthes.spells[id].state)
            if changed then
                currentHealthes.spells[id].state = state
            end
            return changed
        end
    end
    return false
end

local function scanCurrentHealth(unitTarget)
    currentHealthes.healthes = currentHealthes.healthes or {}
    currentHealthes.healthes[unitTarget] = {}
    if UnitExists(unitTarget) then
        currentHealthes.healthes[unitTarget].hasTarget = true
        currentHealthes.healthes[unitTarget].current = UnitHealth(unitTarget)
        currentHealthes.healthes[unitTarget].max = UnitHealthMax(unitTarget)
    else
        currentHealthes.healthes[unitTarget].hasTarget = false
        currentHealthes.healthes[unitTarget].current = 0
        currentHealthes.healthes[unitTarget].max = 0
    end
end

local function watchSpellHealth(id, unitTargets, func)
    if not id then
        return
    end
    currentHealthes.spells = currentHealthes.spells or {}

    local units = currentHealthes.spells[id] and currentHealthes.spells[id].unitTargets or {}

    currentHealthes.spells[id] = {}
    currentHealthes.spells[id].unitTargets = unitTargets or {}
    currentHealthes.spells[id].func = func

    currentHealthes.units = currentHealthes.units or {}
    for _, unit in ipairs(units) do
        if not tcontains(currentHealthes.spells[id].unitTargets, unit) then
            currentHealthes.units[unit] = currentHealthes.units[unit] or {}
            currentHealthes.units[unit][id] = nil
        end
    end
    for _, unit in ipairs(currentHealthes.spells[id].unitTargets) do
        currentHealthes.units[unit] = currentHealthes.units[unit] or {}
        currentHealthes.units[unit][id] = currentHealthes.spells[id].func
    end

    currentHealthes.healthes = currentHealthes.healthes or {}

    for _, unitTarget in ipairs(currentHealthes.spells[id].unitTargets) do
        if not currentHealthes.healthes[unitTarget] then
            scanCurrentHealth(unitTarget)
        end
    end
    handleCurrentHealth(id)
end

function H.scanCurrentHealthes(unitTarget)
    local changed = {}
    if unitTarget and currentHealthes.units and currentHealthes.units[unitTarget] then
        scanCurrentHealth(unitTarget)
        for id, func in pairs(currentHealthes.units[unitTarget]) do
            if func then
                if handleCurrentHealth(id) then
                    changed[id] = currentHealthes.spells
                            and currentHealthes.spells[id]
                            and currentHealthes.spells[id].state
                        or {}
                end
            end
        end
    else
        if currentHealthes.units then
            for unitTarget, _ in pairs(currentHealthes.units) do
                scanCurrentHealth(unitTarget)
            end
        end
        if currentHealthes.spells then
            for id, cache in pairs(currentHealthes.spells) do
                if handleCurrentHealth(id) then
                    changed[id] = cache.state or {}
                end
            end
        end
    end
    if next(changed) then
        WeakAuras.ScanEvents("HWA_UNIT_HEALTH", changed)
    end
end
---------------- Health ------------------

---------------- Totem ------------------
local currentTotems = {}

local function getCurrentTotems(name)
    if name and currentTotems.names then
        return currentTotems.names[name] or {}
    end
    return {}
end

local function handleCurrentTotem(totem, totemSlot)
    if totem and totemSlot then
        currentTotems.totems = currentTotems.totems or {}
        currentTotems.totems[totemSlot] = totem

        currentTotems.names = currentTotems.names or {}
        currentTotems.names[totem.name] = currentTotems.names[totem.name] or {}
        currentTotems.names[totem.name][totemSlot] = totem
    end
end

local function clearCurrentTotems()
    currentTotems = {}
end

local function removeCurrentTotem(totemSlot)
    if currentTotems.totems then
        local totem = currentTotems.totems[totemSlot]
        if totem then
            if currentTotems.names and currentTotems.names[totem.name] then
                currentTotems.names[totem.name][totemSlot] = nil
            end
        end
        currentTotems.totems[totemSlot] = nil
    end
end

function H.scanCurrentTotems(totemSlot)
    if totemSlot then
        local haveTotem, totemName, startTime, duration, icon = GetTotemInfo(totemSlot)
        if haveTotem then
            handleCurrentTotem({
                name = totemName,
                duration = duration,
                expirationTime = startTime + duration,
                icon = icon,
            }, totemSlot)
        else
            removeCurrentTotem(totemSlot)
        end
    else
        clearCurrentTotems()
        for i = 1, MAX_TOTEMS do
            local haveTotem, totemName, startTime, duration, icon = GetTotemInfo(i)
            if haveTotem then
                handleCurrentTotem({
                    name = totemName,
                    duration = duration,
                    expirationTime = startTime + duration,
                    icon = icon,
                }, i)
            end
        end
    end
    WeakAuras.ScanEvents("HWA_UPDATE_TOTEM")
end

function H.initCurrentTotems()
    H.scanCurrentTotems()
end
---------------- Totem ------------------

---------------- Aura ------------------
local currentAuras = {}
local currentUnitTarget, currentFilter

-- id: precise spellID
local function getCurrentAuras(unitTarget, filter, id)
    if unitTarget and filter and id then
        if
            currentAuras[unitTarget]
            and currentAuras[unitTarget][filter]
            and currentAuras[unitTarget][filter].spells
        then
            return currentAuras[unitTarget][filter].spells[id] or {}
        end
    end
    return {}
end

local function handleCurrentAura(aura)
    if aura and currentUnitTarget and currentFilter then
        aura.spellID = aura.spellId

        currentAuras[currentUnitTarget] = currentAuras[currentUnitTarget] or {}
        currentAuras[currentUnitTarget][currentFilter] = currentAuras[currentUnitTarget][currentFilter] or {}

        local cache = currentAuras[currentUnitTarget][currentFilter]

        cache.auras = cache.auras or {}
        cache.auras[aura.auraInstanceID] = aura

        cache.spells = cache.spells or {}
        cache.spells[aura.spellID] = cache.spells[aura.spellID] or {}
        cache.spells[aura.spellID][aura.auraInstanceID] = aura
    end
end

local function clearCurrentAuras(unitTarget, filter)
    currentAuras[unitTarget] = currentAuras[unitTarget] or {}
    currentAuras[unitTarget][filter] = nil
end

local function removeCurrentAura(unitTarget, filter, auraInstanceID)
    if currentAuras[unitTarget] and currentAuras[unitTarget][filter] and currentAuras[unitTarget][filter].auras then
        local aura = currentAuras[unitTarget][filter].auras[auraInstanceID]
        if aura then
            if currentAuras[unitTarget][filter].spells and currentAuras[unitTarget][filter].spells[aura.spellID] then
                currentAuras[unitTarget][filter].spells[aura.spellID][auraInstanceID] = nil
            end
        end
        currentAuras[unitTarget][filter].auras[auraInstanceID] = nil
    end
end

local function scanFilterCurrentAuras(unitTarget, filter, updateInfo)
    if UnitExists(unitTarget) and filter then
        currentUnitTarget = unitTarget
        currentFilter = filter
        if updateInfo and not updateInfo.isFullUpdate then
            if updateInfo.addedAuras then
                for _, aura in ipairs(updateInfo.addedAuras) do
                    if (aura.isHelpful and filter == "HELPFUL") or (aura.isHarmful and filter == "HARMFUL") then
                        handleCurrentAura(aura)
                    end
                end
            end
            if updateInfo.updatedAuraInstanceIDs then
                for _, auraInstanceID in ipairs(updateInfo.updatedAuraInstanceIDs) do
                    local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(unitTarget, auraInstanceID)
                    if aura then
                        if (aura.isHelpful and filter == "HELPFUL") or (aura.isHarmful and filter == "HARMFUL") then
                            handleCurrentAura(aura)
                        end
                    else
                        removeCurrentAura(unitTarget, filter, auraInstanceID)
                    end
                end
            end
            if updateInfo.removedAuraInstanceIDs then
                for _, auraInstanceID in ipairs(updateInfo.removedAuraInstanceIDs) do
                    removeCurrentAura(unitTarget, filter, auraInstanceID)
                end
            end
        else
            clearCurrentAuras(unitTarget, filter)
            AuraUtil.ForEachAura(unitTarget, filter, nil, handleCurrentAura, true)
        end
    else
        clearCurrentAuras(unitTarget, filter)
    end
end

function H.scanCurrentAuras(unitTarget, updateInfo)
    scanFilterCurrentAuras(unitTarget, "HELPFUL", updateInfo)
    scanFilterCurrentAuras(unitTarget, "HARMFUL", updateInfo)
    if unitTarget then
        WeakAuras.ScanEvents("HWA_UNIT_AURA", unitTarget)
    end
end

function H.initCurrentAuras()
    H.scanCurrentAuras("player")
    H.scanCurrentAuras("target")
end
---------------- Aura ------------------

---------------- Trigger ------------------
local function initSpell(env, config, id)
    local config = config or {}
    local id = id or 0
    if id == 0 then
        id = config.id or 0
        if id == 0 then
            local value, _ = env.id:gsub(".+ %- ", "")
            id = tonumber(value) or 0
        end
    end
    if id ~= 0 then
        WeakAuras.WatchSpellCooldown(id)
    end
    if config.range then
        watchSpellRange(id, config.precise or false, { "target" })
    end
    if config.health then
        local func = config.health.func
        if not func then
            local s = config.health.func_string
            if s then
                func = loadFunction(s)
            end
        end
        if func then
            watchSpellHealth(id, { "target" }, func)
        end
    end

    return id
end

-- Get spell info.
local function getSpell(env, cache, config, id)
    local id = id or 0
    if id == 0 then
        return false
    end

    local config = config or {}

    local spell = id
    local spellInfo = C_Spell.GetSpellInfo(spell)
    if spellInfo then
        if not config.precise and spellInfo.name then
            spell = spellInfo.name
            spellInfo = C_Spell.GetSpellInfo(spell)
        end
    end

    if not spellInfo then
        if cache then
            cache.spell = nil
        end
        return true, nil
    end

    local icon = spellInfo.iconID
    local duration = 0
    local expirationTime = 0
    local stacks = 0
    local charges = 1
    local isSpellInRange = true
    local isUsable, noResource = C_Spell.IsSpellUsable(spell)
    local health = {}

    local chargeInfo = C_Spell.GetSpellCharges(spell)
    if chargeInfo then
        if chargeInfo.currentCharges < chargeInfo.maxCharges then
            duration = chargeInfo.cooldownDuration
            expirationTime = chargeInfo.cooldownStartTime + chargeInfo.cooldownDuration
        end
        if chargeInfo.maxCharges > 1 then
            stacks = chargeInfo.currentCharges
        end
        charges = chargeInfo.currentCharges
    else
        local spellCooldownInfo = C_Spell.GetSpellCooldown(spell)
        if spellCooldownInfo and spellCooldownInfo.isEnabled and spellCooldownInfo.duration > 0 then
            local gcdCooldownInfo = C_Spell.GetSpellCooldown(61304)
            if not gcdCooldownInfo or gcdCooldownInfo.duration ~= spellCooldownInfo.duration then
                duration = spellCooldownInfo.duration
                expirationTime = spellCooldownInfo.startTime + spellCooldownInfo.duration
            end
        end
        stacks = C_Spell.GetSpellCastCount(spell)
        charges = 0
    end

    if config.range then
        local range = getCurrentRange(id) or {}

        isSpellInRange = range["target"]
        if isSpellInRange == nil then
            isSpellInRange = true
        end
    end

    if config.health then
        health = getCurrentHealth(id) or {}
    end

    local state = {
        progressType = "timed",
        duration = duration,
        expirationTime = expirationTime,
        icon = icon,
        stacks = stacks,
        charges = charges,
        isUsable = isUsable,
        noResource = noResource,
        isSpellInRange = isSpellInRange,
        health = health,
        gcd = config.gcd or false,
    }

    if cache then
        cache.spell = state
    end

    return true, state
end

-- Get totem info.
local function getTotem(env, cache, config)
    local config = config or {}

    local matchedTotems = {}

    for _, c in ipairs(config) do
        local name = c.name or ""
        if name ~= "" then
            for _, info in pairs(getCurrentTotems(name)) do
                if info and info.name == name then
                    table.insert(matchedTotems, {
                        id = name,
                        name = info.name,
                        duration = info.duration,
                        expirationTime = info.expirationTime,
                        icon = info.icon,
                    })
                end
            end
        end
    end

    for _, totem in ipairs(matchedTotems) do
        totem.progressType = "timed"
    end

    return true, matchedTotems
end

-- Get aura info.
local function getAura(env, cache, config)
    local config = config or {}

    local matchedAuras = {}

    -- Find current auras.
    for _, c in ipairs(config) do
        local id = c.id or 0
        if id ~= 0 then
            local filter
            if c.type == 1 then
                filter = "HELPFUL"
            else
                filter = "HARMFUL"
            end
            for _, unitTarget in ipairs(c.unit_targets or {}) do
                for _, info in pairs(getCurrentAuras(unitTarget, filter, id)) do
                    if info and tcontains(c.source_units, info.sourceUnit) then
                        table.insert(matchedAuras, {
                            id = id,
                            unitTarget = unitTarget,
                            applications = info.applications,
                            auraInstanceID = info.auraInstanceID,
                            charges = info.charges,
                            duration = info.duration,
                            expirationTime = info.expirationTime,
                            icon = info.icon,
                            maxCharges = info.maxCharges,
                            points = info.points,
                            sourceUnit = info.sourceUnit,
                            spellID = info.spellID,
                        })
                    end
                end
            end
        end
    end

    for _, aura in ipairs(matchedAuras) do
        aura.progressType = "timed"
    end

    return true, matchedAuras
end

local function getPower(env, config, type)
    local config = config or {}
    local type = type or -1
    if type < 0 then
        type = config.type or -1
        if type < 0 then
            local name, _ = env.id:gsub(" %- .+", "")
            type = Enum.PowerType[name] or -1
        end
    end
    if type < 0 then
        return false
    end

    local unit = config.unit or "player"
    local unmodified = config.unmodified or false
    local per = config.per or 0

    local current = UnitPower(unit, type, unmodified)
    local max = UnitPowerMax(unit, type, unmodified)
    local total = max
    local count = 1
    if per > 0 then
        total = per
        count = max / per
    end
    local states = {}
    for i = 1, count do
        local state = {
            progressType = "static",
            total = total,
            value = current - per * (i - 1),
        }
        table.insert(states, state)
    end

    return true, states
end

local function getStrategyFunc(env, strategy)
    if strategy then
        if strategy.func then
            return strategy.func
        end
        if strategy.func_string then
            return loadFunction(strategy.func_string)
        end
    end
end

function H.getDefaultSpellStrategyState(env, stateGroup, glow)
    return true, {
        glow = 0,
    }
end

function H.initSpellState(env, config)
    local config = config or {}
    local cache = {}

    cache.id = initSpell(env, config)

    return cache
end

local function getSpellStrategyState(env, strategy, spell)
    local strategy = strategy or {}
    local spell = spell or {}

    for _, s in ipairs(strategy) do
        local func = getStrategyFunc(env, s)
        if func then
            return func(env, {
                spell = spell,
            })
        end
    end

    return H.getDefaultSpellStrategyState(env, {
        spell = spell,
    })
end

function H.getSpellState(env, cache, config)
    local config = config or {}
    if not getStateShow(config.show) then
        return true, nil
    end

    local cache = cache or {}

    local result, state = getSpell(env, cache, config.spell, cache.id)
    if result and state then
        state.priority = getStatePriority(config.priority) or 0
        state.init = getStateInit() or 0

        local r, s = getSpellStrategyState(env, config.strategy, state)
        if r and s then
            state.glow = s.glow
        else
            state.glow = 0
        end
    end

    return result, state
end

function H.getPowerStates(env, config, type)
    local config = config or {}
    if not getStateShow(config.show) then
        return true, nil
    end

    local result, states = getPower(env, config.power, type)
    if result and states then
        for _, state in ipairs(states) do
            state.init = getStateInit()
        end
    end

    return result, states
end

function H.getDefaultTotemStrategyState(env, stateGroup, glow)
    local states = stateGroup and stateGroup.totems or {}

    if not next(states) then
        return true, nil
    end

    table.sort(states, function(a, b)
        return a.expirationTime < b.expirationTime
    end)
    local s = states[1]
    local stacks = #states
    if stacks == 1 then
        stacks = 0
    end
    local glow = glow or 0
    if not s.expirationTime or s.expirationTime <= 0 then
        glow = 0
    end
    return true,
        {
            progressType = s.progressType,
            duration = s.duration,
            expirationTime = s.expirationTime,
            icon = s.icon,
            stacks = stacks,
            glow = glow,
        }
end

function H.getNormalTotemStrategyState(env, stateGroup)
    return H.getDefaultTotemStrategyState(env, stateGroup, 1)
end

function H.getNoticeTotemStrategyState(env, stateGroup)
    return H.getDefaultTotemStrategyState(env, stateGroup, 2)
end

function H.getImportantTotemStrategyState(env, stateGroup)
    return H.getDefaultTotemStrategyState(env, stateGroup, 3)
end

function H.initTotemState(env, config)
    local config = config or {}
    local cache = {}

    local matchedTotem = {}
    for _, c in ipairs(config.totem or {}) do
        local name = c.name or ""
        if name ~= "" then
            matchedTotem[name] = {}
        end
    end

    cache.matchedTotem = matchedTotem

    return cache
end

local function getTotemStrategyState(env, strategy, states)
    local strategy = strategy or {}
    local states = states or {}

    for _, s in ipairs(strategy) do
        local match = true
        for _, id in ipairs(s.match and s.match.totem or {}) do
            local find = false
            for _, state in ipairs(states) do
                if id == state.id then
                    find = true
                    break
                end
            end
            if not find then
                match = false
                break
            end
        end
        if match then
            local func = getStrategyFunc(env, s)
            if func then
                return func(env, {
                    totems = states,
                })
            end
        end
    end

    return H.getDefaultTotemStrategyState(env, {
        totems = states,
    })
end

local function getTotemStates(env, cache, config)
    return getTotem(env, cache, config)
end

function H.getTotemState(env, cache, config)
    local config = config or {}
    if not getStateShow(config.show) then
        return true, nil
    end

    local result, states = getTotemStates(env, cache, config.totem)
    if result then
        local r, s = getTotemStrategyState(env, config.strategy, states)
        if r and s then
            s.priority = getStatePriority(config.priority) or 0
            s.init = getStateInit() or 0
        end
        return r, s
    end
    return false
end

function H.getDefaultAuraStrategyState(env, stateGroup, glow)
    local states = stateGroup and stateGroup.auras or {}
    if not next(states) then
        return true, nil
    end

    table.sort(states, function(a, b)
        return a.expirationTime < b.expirationTime
    end)
    local s = states[1]
    local stacks = 0
    if s.applications and s.applications > 1 then
        stacks = s.applications
    end
    local glow = glow or 0
    if not s.expirationTime or s.expirationTime <= 0 then
        glow = 0
    end
    return true,
        {
            progressType = s.progressType,
            duration = s.duration,
            expirationTime = s.expirationTime,
            icon = s.icon,
            stacks = stacks,
            glow = glow,
        }
end

function H.getNormalAuraStrategyState(env, stateGroup)
    return H.getDefaultAuraStrategyState(env, stateGroup, 1)
end

function H.getNoticeAuraStrategyState(env, stateGroup)
    return H.getDefaultAuraStrategyState(env, stateGroup, 2)
end

function H.getImportantAuraStrategyState(env, stateGroup)
    return H.getDefaultAuraStrategyState(env, stateGroup, 3)
end

function H.initAuraState(env, config)
    local config = config or {}
    local cache = {}

    local matchedAura = {}
    for _, c in ipairs(config.aura or {}) do
        local id = c.id or 0
        if id ~= 0 then
            for _, unit in ipairs(c.unit_targets or {}) do
                matchedAura[unit] = matchedAura[unit] or {}
                -- Insert id into unit-ids map.
                table.insert(matchedAura[unit], id)
            end
        end
    end

    cache.matchedAura = matchedAura

    return cache
end

local function getAuraStrategyState(env, strategy, states)
    local strategy = strategy or {}
    local states = states or {}

    for _, s in ipairs(strategy) do
        local match = true
        for _, id in ipairs(s.match and s.match.aura or {}) do
            local find = false
            for _, state in ipairs(states) do
                if id == state.id then
                    find = true
                    break
                end
            end
            if not find then
                match = false
                break
            end
        end
        if match then
            local func = getStrategyFunc(env, s)
            if func then
                return func(env, {
                    auras = states,
                })
            end
        end
    end

    return H.getDefaultAuraStrategyState(env, {
        auras = states,
    })
end

local function getAuraStates(env, cache, config)
    return getAura(env, cache, config)
end

function H.getAuraState(env, cache, config)
    local config = config or {}
    if not getStateShow(config.show) then
        return true, nil
    end

    local result, states = getAuraStates(env, cache, config.aura)
    if result then
        local r, s = getAuraStrategyState(env, config.strategy, states)
        if r and s then
            s.priority = getStatePriority(config.priority) or 0
            s.init = getStateInit() or 0
        end
        return r, s
    end
    return false
end

function H.getDefaultCoreStrategyState(env, stateGroup, glow)
    local result, state = H.getDefaultTotemStrategyState(env, stateGroup, glow)
    if result and state then
        return result, state
    end
    return H.getDefaultAuraStrategyState(env, stateGroup, glow)
end

function H.getNormalCoreStrategyState(env, stateGroup)
    return H.getDefaultCoreStrategyState(env, stateGroup, 1)
end

function H.getNoticeCoreStrategyState(env, stateGroup)
    return H.getDefaultCoreStrategyState(env, stateGroup, 2)
end

function H.getImportantCoreStrategyState(env, stateGroup)
    return H.getDefaultCoreStrategyState(env, stateGroup, 3)
end

function H.initCoreStates(env, config)
    local config = config or {}
    local cache = {}

    local data = {}
    local matchedTotem = {}
    local matchedAura = {}

    for i, c in ipairs(config) do
        local id = initSpell(env, c.spell)
        if id ~= 0 then
            data[id] = {}
            data[id].id = id
            data[id].info = c
            data[id].index = i
            if c.totem then
                table.insert(matchedTotem, id)
            end
            for _, aura in ipairs(c.aura or {}) do
                for _, unit in ipairs(aura.unit_targets or {}) do
                    matchedAura[unit] = matchedAura[unit] or {}
                    -- Insert id into unit-ids map.
                    table.insert(matchedAura[unit], id)
                end
            end
        end
    end

    cache.data = data
    cache.matchedTotem = matchedTotem
    cache.matchedAura = matchedAura

    return cache
end

local function getCoreStrategyState(env, strategy, spell, totems, auras)
    local strategy = strategy or {}
    local spell = spell or {}
    local totems = totems or {}
    local auras = auras or {}

    for _, s in ipairs(strategy) do
        local match = true
        for _, id in ipairs(s.match and s.match.totem or {}) do
            local find = false
            for _, state in ipairs(totems) do
                if id == state.id then
                    find = true
                    break
                end
            end
            if not find then
                match = false
                break
            end
        end
        for _, id in ipairs(s.match and s.match.aura or {}) do
            local find = false
            for _, state in ipairs(auras) do
                if id == state.id then
                    find = true
                    break
                end
            end
            if not find then
                match = false
                break
            end
        end
        if match then
            local func = getStrategyFunc(env, s)
            if func then
                return func(env, {
                    spell = spell,
                    totems = totems,
                    auras = auras,
                })
            end
        end
    end

    return H.getNormalCoreStrategyState(env, {
        spell = spell,
        totems = totems,
        auras = auras,
    })
end

local function getCoreState(env, cache, config, id)
    if not id then
        return false
    end

    local config = config or {}
    if not getStateShow(config.show) then
        return true, nil
    end

    local cache = cache or {}

    local result, state = getSpell(env, cache, config.spell, id)
    if result and state then
        state.priority = getStatePriority(config.priority) or 0
        state.init = getStateInit() or 0

        local totemStates
        if config.totem then
            _, totemStates = getTotemStates(env, cache, config.totem)
        end
        local auraStates
        if config.aura then
            _, auraStates = getAuraStates(env, cache, config.aura)
        end
        local r, s = getCoreStrategyState(env, config.strategy, state, totemStates, auraStates)
        if r and s then
            state.subDuration = s.duration
            state.subExpirationTime = s.expirationTime
            state.subStacks = s.stacks
            state.glow = s.glow
        else
            state.subDuration = 0
            state.subExpirationTime = 0
            state.subStacks = 0
            state.glow = 0
        end
    end
    return result, state
end

function H.getCoreStates(env, cache, config, checkList)
    local cache = cache or {}
    local config = config or {}
    local checkList = checkList or {}

    local states = {}

    local data = cache.data or {}
    if not next(checkList) then
        -- Check all in config.
        for id, c in pairs(data) do
            local result, state = getCoreState(env, c, c.info, id)
            if result and state then
                state.id = id
                state.index = c.index or 0
                states[id] = state
            end
        end
    else
        for id, _ in pairs(checkList) do
            local c = data[id] or {}
            local result, state = getCoreState(env, c, c.info, id)
            if result and state then
                state.id = id
                state.index = c.index or 0
                states[id] = state
            end
        end
    end

    return true, states
end

function H.getDefaultDynamicEffectStrategyState(env, stateGroup, glow)
    local result, state = H.getDefaultTotemStrategyState(env, stateGroup, glow)
    if result and state then
        return result, state
    end
    return H.getDefaultAuraStrategyState(env, stateGroup, glow)
end

function H.getNormalDynamicEffectStrategyState(env, stateGroup)
    return H.getDefaultDynamicEffectStrategyState(env, stateGroup, 1)
end

function H.getNoticeDynamicEffectStrategyState(env, stateGroup)
    return H.getDefaultDynamicEffectStrategyState(env, stateGroup, 2)
end

function H.getImportantDynamicEffectStrategyState(env, stateGroup)
    return H.getDefaultDynamicEffectStrategyState(env, stateGroup, 3)
end

function H.initDynamicEffectStates(env, config)
    local config = config or {}
    local cache = {}

    local data = {}
    local matchedTotem = {}
    local matchedAura = {}

    for i, c in ipairs(config) do
        data[i] = {}
        data[i].info = c
        data[i].index = i

        if c.totem then
            table.insert(matchedTotem, i)
        end
        for _, aura in ipairs(c.aura or {}) do
            for _, unit in ipairs(aura.unit_targets or {}) do
                matchedAura[unit] = matchedAura[unit] or {}
                -- Insert id into unit-ids map.
                table.insert(matchedAura[unit], i)
            end
        end
    end

    cache.data = data
    cache.matchedTotem = matchedTotem
    cache.matchedAura = matchedAura

    return cache
end

local function getDynamicEffectStrategyState(env, strategy, totems, auras)
    local strategy = strategy or {}
    local totems = totems or {}
    local auras = auras or {}

    for _, s in ipairs(strategy) do
        local match = true
        for _, id in ipairs(s.match and s.match.totem or {}) do
            local find = false
            for _, state in ipairs(totems) do
                if id == state.id then
                    find = true
                    break
                end
            end
            if not find then
                match = false
                break
            end
        end
        for _, id in ipairs(s.match and s.match.aura or {}) do
            local find = false
            for _, state in ipairs(auras) do
                if id == state.id then
                    find = true
                    break
                end
            end
            if not find then
                match = false
                break
            end
        end
        if match then
            local func = getStrategyFunc(env, s)
            if func then
                return func(env, {
                    totems = totems,
                    auras = auras,
                })
            end
        end
    end

    return H.getDefaultDynamicEffectStrategyState(env, {
        totems = totems,
        auras = auras,
    })
end

local function getDynamicEffectState(env, cache, config)
    local config = config or {}
    if not getStateShow(config.show) then
        return true, nil
    end

    local cache = cache or {}

    local totemStates
    if config.totem then
        _, totemStates = getTotemStates(env, cache, config.totem)
    end
    local auraStates
    if config.aura then
        _, auraStates = getAuraStates(env, cache, config.aura)
    end
    local result, state = getDynamicEffectStrategyState(env, config.strategy, totemStates, auraStates)
    if result and state then
        state.priority = getStatePriority(config.priority) or 0
        state.init = getStateInit() or 0
    end

    return result, state
end

function H.getDynamicEffectStates(env, cache, config, checkList)
    local cache = cache or {}
    local config = config or {}
    local checkList = checkList or {}

    local states = {}

    local data = cache.data or {}
    if not next(checkList) then
        -- Check all in config.
        for id, c in pairs(data) do
            local result, state = getDynamicEffectState(env, c, c.info)
            if result and state then
                state.id = id
                state.index = c.index or 0
                states[id] = state
            end
        end
    else
        for id, _ in pairs(checkList) do
            local c = data[id] or {}
            local result, state = getDynamicEffectState(env, c, c.info)
            if result and state then
                state.id = id
                state.index = c.index or 0
                states[id] = state
            end
        end
    end

    return true, states
end
---------------- Trigger ------------------

---------------- Region ------------------
local function setRegionSize(r, w, h)
    r:SetRegionWidth(w)
    r:SetRegionHeight(h)
end

local function baseGrow(
    newPositions,
    activeRegions,
    width,
    height,
    hSpacing,
    vSpacing,
    direction,
    minCount,
    maxCount,
    remainCount,
    growType,
    xOffset,
    yOffset
)
    local grow = 1
    if growType == 3 then
        grow = -1
    end
    local lineCount = 0
    local maxLine = maxCount
    local midLine = 0
    local minLine = 0

    local count = remainCount
    while count > 0 do
        if count < maxCount then
            minLine = count
            count = 0
            lineCount = lineCount + 1
        elseif count < maxCount * 2 then
            if count - maxCount < minCount then
                midLine = count - minCount
            else
                midLine = maxCount
            end
            minLine = count - midLine
            count = count - midLine - minLine
            lineCount = lineCount + 2
        else
            count = count - maxLine
            lineCount = lineCount + 1
        end
    end

    local currentLine = 0
    if lineCount > 2 then
        currentLine = maxLine
    elseif lineCount > 1 then
        currentLine = midLine
    else
        currentLine = minLine
    end
    local currentMid = 1
    if growType == 2 then
        currentMid = (currentLine + 1) / 2
    end
    local currentMin = #activeRegions - remainCount
    local currentMax = currentMin + currentLine
    local y = yOffset
    for i, regionData in ipairs(activeRegions) do
        if i > currentMin then
            setRegionSize(regionData.region, width, height)
            newPositions[i] = { (i - currentMin - currentMid) * (width + hSpacing) * grow + xOffset, y }
            if i == currentMax then
                lineCount = lineCount - 1
                if lineCount > 2 then
                    currentLine = maxLine
                elseif lineCount > 1 then
                    currentLine = midLine
                else
                    currentLine = minLine
                end
                if growType == 2 then
                    currentMid = (currentLine + 1) / 2
                end
                currentMin = currentMax
                currentMax = currentMin + currentLine
                y = y + (height + vSpacing) * direction
            end
        end
    end
end

local function baseSort(a, b)
    local priorityA = a.region and a.region.state and a.region.state.priority or 0
    local priorityB = b.region and b.region.state and b.region.state.priority or 0
    if priorityA ~= priorityB then
        return priorityA < priorityB
    end
    local indexA = a.region and a.region.state and a.region.state.index or 0
    local indexB = b.region and b.region.state and b.region.state.index or 0
    if indexA ~= indexB then
        return indexA < indexB
    end
    return a.dataIndex < b.dataIndex
end

function H.coreGrow(newPositions, activeRegions, class)
    local config = H.getConfig("core", class)
    local xOffset = config.x_offset
    local yOffset = config.y_offset
    local width = config.width
    local height = config.height
    local hSpacing = config.horizontal_spacing
    local vSpacing = config.vertical_spacing
    local direction = 1
    if config.direction == 2 then
        direction = -1
    end

    local iconCount = #activeRegions
    local maxSize = config.max_icon_size_pl
    local maxOverflow = 0
    if maxSize > iconCount then
        maxSize = iconCount
    else
        maxOverflow = iconCount - maxSize
    end

    local mid = (maxSize + 1) / 2
    for i, regionData in ipairs(activeRegions) do
        setRegionSize(regionData.region, width, height)
        newPositions[i] = { (i - mid) * (width + hSpacing) + xOffset, yOffset }
        if i == maxSize then
            break
        end
    end

    if maxOverflow > 0 then
        local subWidth = config.sub_width
        local subHeight = config.sub_height
        local subHSpacing = config.sub_horizontal_spacing
        local subVSpacing = config.sub_vertical_spacing
        local subSpacing = config.sub_spacing
        local maxCount = config.max_sub_icon_size_pl
        local minCount = config.min_sub_icon_size_pl

        baseGrow(
            newPositions,
            activeRegions,
            subWidth,
            subHeight,
            subHSpacing,
            subVSpacing,
            direction,
            minCount,
            maxCount,
            maxOverflow,
            2,
            xOffset,
            (subSpacing + (height - 1) / 2 + (subHeight - 1) / 2 + 1) * direction + yOffset
        )
    end
end

function H.coreSort(a, b)
    return baseSort(a, b)
end

function H.resourceGrow(newPositions, activeRegions, class)
    local config = H.getConfig("resource", class)
    local xOffset = config.x_offset
    local yOffset = config.y_offset
    local totalWidth = config.total_width
    local height = config.height
    local hSpacing = config.horizontal_spacing

    local count = #activeRegions
    local width = (totalWidth - (count - 1) * hSpacing) / count
    local mid = (count + 1) / 2

    for i, regionData in ipairs(activeRegions) do
        setRegionSize(regionData.region, width, height)
        newPositions[i] = { (i - mid) * (width + hSpacing) + xOffset, yOffset }
    end
end

function H.dynamicEffectsGrow(newPositions, activeRegions, class)
    local config = H.getConfig("dynamic_effects", class)
    local xOffset = config.x_offset
    local yOffset = config.y_offset
    local width = config.width
    local height = config.height
    local hSpacing = config.horizontal_spacing
    local vSpacing = config.vertical_spacing
    local direction = 1
    if config.direction == 2 then
        direction = -1
    end
    local maxSize = config.max_icon_size_pl
    local growType = config.grow
    local grow = 1
    if growType == 3 then
        grow = -1
    end

    local x0 = xOffset
    if growType ~= 2 then
        x0 = x0 + ((width - 1) / 2 + 1) * grow
    end
    baseGrow(
        newPositions,
        activeRegions,
        width,
        height,
        hSpacing,
        vSpacing,
        direction,
        0,
        maxSize,
        #activeRegions,
        growType,
        x0,
        yOffset
    )
end

function H.dynamicEffectsSort(a, b)
    return baseSort(a, b)
end

function H.maintenanceGrow(newPositions, activeRegions, class)
    local config = H.getConfig("maintenance", class)
    local xOffset = config.x_offset
    local yOffset = config.y_offset
    local width = config.width
    local height = config.height
    local hSpacing = config.horizontal_spacing
    local vSpacing = config.vertical_spacing
    local direction = 1
    if config.direction == 2 then
        direction = -1
    end
    local maxSize = config.max_icon_size_pl

    baseGrow(
        newPositions,
        activeRegions,
        width,
        height,
        hSpacing,
        vSpacing,
        direction,
        0,
        maxSize,
        #activeRegions,
        2,
        xOffset,
        yOffset
    )
end

function H.maintenanceSort(a, b)
    return baseSort(a, b)
end
---------------- Region ------------------

---------------- Init ------------------
-- Local copy.
local C_Timer = C_Timer

local initThrottledHandler = nil
local initThrottledLastRunTime = 0

if WeakAuras.IsImporting() then
    local function checkImport()
        if WeakAuras.IsImporting() or not env.IsImporting then
            return
        end

        env.isImporting:Cancel()
        env.isImporting = false

        C_Timer.After(1, function()
            WeakAuras.ScanEvents("HWA_INIT", true)
        end)
    end

    env.isImporting = C_Timer.NewTicker(0.5, checkImport)
else
    env.isImporting = false
end

function H.initThrottled()
    if initThrottledHandler or env.isImporting then
        return
    end

    initThrottledHandler = C_Timer.NewTimer(0.25, function()
        WeakAuras.ScanEvents("HWA_INIT")
    end)
end

function H.init()
    if env.isImporting then
        return
    end

    initThrottledLastRunTime = time()

    updateEnv()

    if initThrottledHandler then
        initThrottledHandler:Cancel()
        initThrottledHandler = nil
    end

    WeakAuras.ScanEvents("HWA_UPDATE", "init")
end

hooksecurefunc("SetUIVisibility", function(isVisible)
    if isVisible and H and H.initThrottled then
        H.initThrottled()
    end
end)
---------------- Init ------------------
