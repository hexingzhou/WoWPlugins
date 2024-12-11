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
                                y_offset = 73,
                            },
                            dynamic_effects = {
                                y_offset = 149,
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
                                y_offset = 73,
                            },
                            dynamic_effects = {
                                y_offset = 149,
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
                                y_offset = 73,
                            },
                            dynamic_effects = {
                                y_offset = 149,
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

-- Start GCD watching. This is used for GCD check in getSpell function.
WeakAuras.WatchGCD()

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

function H.loadFunction(str)
    return function_cache_custom:load(str)
end

-- 1: solo
-- 5: party
-- 20: mythic raid
-- 30: normal raid
-- 40: outdoor raid
function H.getLocalGroupID()
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

function H.getStateShow(config)
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
function H.getStateInit()
    return (env.specID or 0) * 10000 + (env.groupID or 0) * 100 + (env.formID or 0)
end

-- The priority value is used to trigger group sort.
function H.getStatePriority(config)
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

function H.updateEnv()
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
    local groupID = H.getLocalGroupID() or 0
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

---------------- Aura ------------------
local _currentAuras = {}
local _unitTarget, _filter

function H.handleCurrentAura(aura)
    if aura and _unitTarget and _filter then
        _currentAuras[_unitTarget] = _currentAuras[_unitTarget] or {}
        _currentAuras[_unitTarget][_filter] = _currentAuras[_unitTarget][_filter] or {}

        local cache = _currentAuras[_unitTarget][_filter]

        cache.auras = cache.auras or {}
        cache.auras[aura.auraInstanceID] = aura

        cache.spells = cache.spells or {}
        cache.spells[aura.spellId] = cache.spells[aura.spellId] or {}
        cache.spells[aura.spellId][aura.auraInstanceID] = aura
    end
end

function H.clearCurrentAuras(unitTarget, filter)
    _currentAuras[_unitTarget] = _currentAuras[_unitTarget] or {}
    _currentAuras[_unitTarget][_filter] = nil
end

function H.scanCurrentAuras(unitTarget, filter, updateInfo)
    if UnitExists(unitTarget) and filter then
        _unitTarget = unitTarget
        _filter = filter
        if updateInfo and not updateInfo.isFullUpdate then
            if updateInfo.addedAuras then
                for _, aura in ipairs(updateInfo.addedAuras) do
                    if (aura.isHelpful and filter == "HELPFUL") or (aura.isHarmful and filter == "HARMFUL") then
                        H.handleCurrentAura(aura)
                    end
                end
            end
            if updateInfo.updatedAuraInstanceIDs then
                for _, auraInstanceID in ipairs(updateInfo.updatedAuraInstanceIDs) do
                    local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(unitTarget, auraInstanceID)
                    if (aura.isHelpful and filter == "HELPFUL") or (aura.isHarmful and filter == "HARMFUL") then
                        H.handleCurrentAura(aura)
                    end
                end
            end
            if updateInfo.removedAuraInstanceIDs then
                for _, auraInstanceID in ipairs(updateInfo.removedAuraInstanceIDs) do
                    if
                        _currentAuras[unitTarget]
                        and _currentAuras[unitTarget][filter]
                        and _currentAuras[unitTarget][filter].auras
                    then
                        local aura = _currentAuras[unitTarget][filter].auras[auraInstanceID]
                        if aura then
                            if
                                _currentAuras[unitTarget][filter]
                                and _currentAuras[unitTarget][filter].spells
                                and _currentAuras[unitTarget][filter].spells[aura.spellId]
                            then
                                _currentAuras[unitTarget][filter].spells[aura.spellId][auraInstanceID] = nil
                            end
                        end
                        _currentAuras[unitTarget][filter].auras[auraInstanceID] = nil
                    end
                end
            end
        else
            H.clearCurrentAuras(unitTarget, filter)
            AuraUtil.ForEachAura(unitTarget, filter, nil, H.handleCurrentAura, true)
        end
    else
        H.clearCurrentAuras(unitTarget, filter)
    end

    if unitTarget then
        WeakAuras.ScanEvents("HWA_UNIT_AURA", unitTarget)
    end
end

function H.initCurrentAuras()
    H.scanCurrentAuras("player", "HELPFUL")
    H.scanCurrentAuras("player", "HARMFUL")
    H.scanCurrentAuras("target", "HELPFUL")
    H.scanCurrentAuras("target", "HARMFUL")
end

function H.getCurrentAuras()
    return _currentAuras
end
---------------- Aura ------------------

---------------- Trigger ------------------
function H.initSpell(env, config, id)
    local spellID = id or 0
    if spellID == 0 then
        spellID = config.id or 0
        if spellID == 0 then
            local value, _ = env.id:gsub(".+ %- ", "")
            spellID = tonumber(value) or 0
        end
    end
    if spellID ~= 0 then
        WeakAuras.WatchSpellCooldown(spellID)
    end
    return spellID
end

-- Get spell info.
function H.getSpell(env, config, id)
    local config = config or {}
    if not H.getStateShow(config.show) then
        return true, {
            show = false,
        }
    end

    local spellID = id or 0
    if spellID == 0 then
        spellID = config.id or 0
        if spellID == 0 then
            local value, _ = env.id:gsub(".+ %- ", "")
            spellID = tonumber(value) or 0
        end
    end
    if spellID == 0 then
        return false
    end

    local spell = spellID
    local spellInfo = C_Spell.GetSpellInfo(spell)
    if spellInfo then
        if not config.precise then
            spell = spellInfo.name
            spellInfo = C_Spell.GetSpellInfo(spell)
        end
    end

    if not spellInfo then
        return true, {
            show = false,
        }
    end

    local target = config.target or false

    local icon = spellInfo.iconID
    local duration = 0
    local expirationTime = 0
    local stacks = 0
    local charges = 1
    local isSpellInRange = true
    local hasTarget = false
    local isUsable, noResource = C_Spell.IsSpellUsable(spell)
    local healthPercent = 0

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
        if
            spellCooldownInfo
            and spellCooldownInfo.isEnabled
            and spellCooldownInfo.duration > 0
            and spellCooldownInfo.duration ~= WeakAuras.gcdDuration()
        then
            duration = spellCooldownInfo.duration
            expirationTime = spellCooldownInfo.startTime + spellCooldownInfo.duration
        end
        stacks = C_Spell.GetSpellCastCount(spell)
        charges = stacks
    end

    if target then
        local inRange = C_Spell.IsSpellInRange(spell, "target")
        if inRange ~= nil then
            isSpellInRange = inRange == 1
            hasTarget = true
            healthPercent = UnitHealth("target") / UnitHealthMax("target") * 100
        end
    end

    return true,
        {
            show = true,
            progressType = "timed",
            duration = duration,
            expirationTime = expirationTime,
            icon = icon,
            stacks = stacks,
            charges = charges,
            isUsable = isUsable,
            noResource = noResource,
            isSpellInRange = isSpellInRange,
            hasTarget = hasTarget,
            healthPercent = healthPercent,
            gcd = config.gcd or false,
            priority = H.getStatePriority(config.priority) or 0,
            init = H.getStateInit() or 0,
        }
end

-- Get totem info.
function H.getTotem(env, cache, config, totemSlot)
    if not totemSlot then
        return false
    end

    local config = config or {}
    local totems = cache and cache.totems or {}

    local haveTotem, totemName, startTime, duration, icon = GetTotemInfo(totemSlot)

    if haveTotem then
        local inCache = false
        for name, c in pairs(config) do
            if name == totemName then
                for i, totem in ipairs(totems) do
                    if totem.totemSlot == totemSlot then
                        totem.id = c.id or 0
                        totem.name = name
                        totem.duration = duration
                        totem.expirationTime = startTime + duration
                        totem.icon = icon
                        inCache = true
                        break
                    end
                end
            end
        end
        if not inCache then
            local name, _ = env.id:gsub(" %- %d+", "")
            if name == totemName then
                for i, totem in ipairs(totems) do
                    if totem.totemSlot == totemSlot then
                        totem.id = c.id or 0
                        totem.name = name
                        totem.duration = duration
                        totem.expirationTime = startTime + duration
                        totem.icon = icon
                        inCache = true
                        break
                    end
                end
            end
        end
        if not inCache then
            local totem = {
                id = c.id or 0,
                totemSlot = totemSlot,
                name = name,
                duration = duration,
                expirationTime = startTime + duration,
                icon = icon,
            }
            table.insert(totems, totem)
        end
    else
        for i = #totems, 1, -1 do
            local totem = totems[i]
            if totem.totemSlot == totemSlot then
                table.remove(totems, i)
            end
        end
    end

    if cache then
        cache.totems = totems
    end

    local states = {}
    for i, totem in ipairs(totems) do
        local state = {
            progressType = "timed",
            id = totem.id,
            totemSlot = totem.totemSlot,
            name = totem.name,
            duration = totem.duration,
            expirationTime = totem.expirationTime,
            icon = totem.icon,
        }
        table.insert(states, state)
    end

    if not next(states) then
        return true, {
            show = false,
        }
    else
        return true, {
            show = true,
            states = states,
        }
    end
end

-- Get aura info.
function H.getAura(env, cache, config, unitTarget)
    if not unitTarget then
        return false
    end

    local config = config or {}
    local auras = cache and cache.auras or {}

    local currentAuras = {}

    -- Find current auras.
    for id, c in pairs(config) do
        local unitTargets = c.unit_targets
        local sourceUnits = c.source_units
        if tcontains(unitTargets, unitTarget) then
            local info = C_UnitAuras.GetAuraDataByAuraInstanceID(unitTarget, id)
            if info and tcontains(sourceUnits, info.sourceUnit) then
                table.insert(currentAuras, {
                    id = c.id or 0,
                    unitTarget = unitTarget,
                    auraInstanceID = auraData.auraInstanceID,
                    charges = auraData.charges,
                    duration = auraData.duration,
                    expirationTime = auraData.expirationTime,
                    icon = auraData.icon,
                    maxCharges = auraData.maxCharges,
                    points = auraData.points,
                    sourceUnit = auraData.sourceUnit,
                    spellID = auraData.spellId,
                })
            end
        end
    end

    -- Update auras cache.
    auras[unitTarget] = currentAuras

    if cache then
        cache.auras = auras
    end

    if not next(auras) then
        return true, {
            show = false,
        }
    end

    local states = {}
    for _, unitTargetAuras in pairs(auras) do
        for i, aura in ipairs(unitTargetAuras) do
            table.insert(states, {
                progressType = "timed",
                id = aura.id,
                unitTarget = aura.unitTarget,
                auraInstanceID = aura.auraInstanceID,
                charges = aura.charges,
                duration = aura.duration,
                expirationTime = aura.expirationTime,
                icon = aura.icon,
                maxCharges = aura.maxCharges,
                points = aura.points,
                sourceUnit = aura.sourceUnit,
                spellID = aura.spellId,
            })
        end
    end

    if not next(states) then
        return true, {
            show = false,
        }
    else
        return true, {
            show = true,
            states = states,
        }
    end
end

function H.getPower(env, config, type)
    local config = config or {}
    if not H.getStateShow(config.show) then
        return true, {
            show = false,
        }
    end

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
            init = H.getStateInit(),
        }
        table.insert(states, state)
    end

    if not next(states) then
        return true, {
            show = false,
        }
    else
        return true, {
            show = true,
            states = states,
        }
    end
end

function H.getStrategyFunc(env, strategy)
    if strategy then
        if strategy.func then
            return strategy.func
        end
        if strategy.func_string then
            return H.loadFunction(strategy.func_string)
        end
    end
end

function H.getDefaultTotemStrategyState(env, states)
    local states = states or {}

    if not next(states) then
        return true, {
            show = false,
        }
    end

    table.sort(states, function(a, b)
        return a.expirationTime < b.expirationTime
    end)
    local s = states[1]
    local stacks = #states
    if stacks == 1 then
        stacks = 0
    end
    return true,
        {
            show = true,
            progressType = s.progressType,
            duration = s.duration,
            expirationTime = s.expirationTime,
            icon = s.icon,
            stacks = stacks,
            glow = 1,
        }
end

function H.getTotemStrategyState(env, strategy, states)
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
            local func = H.getStrategyFunc(env, s)
            if func then
                return func(env, states)
            end
        end
    end

    return H.getDefaultTotemStrategyState(env, states)
end

function H.getTotemStates(env, cache, config, totemSlots)
    local totemSlots = totemSlots or {}
    if #totemSlots == 0 then
        for i = 1, MAX_TOTEMS do
            table.insert(totemSlots, i)
        end
    end
    local result, state = nil, nil
    for _, totemSlot in ipairs(totemSlots) do
        local r, s = H.getTotem(env, cache, config, totemSlot)
        if r and s then
            result = r
            state = s
        end
    end
    return result, state
end

function H.getTotemState(env, cache, config, strategy, totemSlots)
    local result, state = H.getTotemStates(env, cache, config, totemSlots)
    if result and state then
        if state.show then
            return H.getTotemStrategyState(env, strategy, state.states)
        else
            return true, {
                show = false,
            }
        end
    end
    return false
end

function H.getDefaultAuraStrategyState(env, states)
    local states = states or {}

    if not next(states) then
        return true, {
            show = false,
        }
    end

    table.sort(states, function(a, b)
        return a.expirationTime < b.expirationTime
    end)
    local s = states[1]
    local stacks = 0
    if s.maxCharges > 1 then
        stacks = s.charges
    end
    return true,
        {
            show = true,
            progressType = s.progressType,
            duration = s.duration,
            expirationTime = s.expirationTime,
            icon = s.icon,
            stacks = stacks,
            glow = 1,
        }
end

function H.getNoticeAuraStrategyState(env, states)
    local result, state = H.getDefaultAuraStrategyState(env, states)
    if result and state and state.show then
        state.glow = 3
    end
    return result, state
end

function H.getAuraStrategyState(env, strategy, states)
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
            local func = H.getStrategyFunc(env, s)
            if func then
                return func(env, states)
            end
        end
    end

    return H.getDefaultAuraStrategyState(env, states)
end

function H.getAuraStates(env, cache, config, unitTargets)
    local unitTargets = unitTargets or {}
    if #unitTargets == 0 then
        local units = {}
        for _, c in pairs(config or {}) do
            for _, unit in ipairs(c.unit_targets or {}) do
                units[unit] = true
            end
        end
        for unitTarget, _ in pairs(units) do
            table.insert(unitTargets, unitTarget)
        end
    end
    local result, state = nil, nil
    for _, unitTarget in ipairs(unitTargets) do
        local r, s = H.getAura(env, cache, config, unitTarget)
        if r and s then
            result = r
            state = s
        end
    end
    return result, state
end

function H.getAuraState(env, cache, config, strategy, unitTargets)
    local result, state = H.getAuraStates(env, cache, config, unitTargets)
    if result and state then
        if state.show then
            return H.getAuraStrategyState(env, strategy, state.states)
        else
            return true, {
                show = false,
            }
        end
    end
    return false
end

function H.initCoreStates(env, config)
    local config = config or {}
    local cache = {}

    local targetList = {}
    local auraList = {}
    local totemList = {}

    for i, c in pairs(config) do
        local id = c.spell and c.spell.id or 0
        if id ~= 0 then
            WeakAuras.WatchSpellCooldown(id)

            cache[id] = c
            cache[id].index = i

            if c.spell and c.spell.target then
                table.insert(targetList, id)
            end
            if c.totem then
                table.insert(totemList, id)
            end
            for _, aura in pairs(c.aura or {}) do
                for _, unit in ipairs(aura.unit_targets or {}) do
                    auraList[unit] = auraList[unit] or {}
                    table.insert(auraList[unit], id)
                end
            end
        end
    end

    cache.targetList = targetList
    cache.auraList = auraList
    cache.totemList = totemList

    return cache
end

function H.getCoreStrategyState(env, strategy, totems, auras)
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
            local func = H.getStrategyFunc(env, s)
            if func then
                return func(env, totems, auras)
            end
        end
    end

    local result, state = H.getDefaultTotemStrategyState(env, totems)
    if result and state and state.show then
        return result, state
    end
    return H.getDefaultAuraStrategyState(env, auras)
end

function H.getCoreState(env, cache, config, id, param)
    if not id then
        return false
    end

    local cache = cache or {}
    local config = config or {}

    local result, state = H.getSpell(env, config.spell, id)
    if result and state and state.show then
        local param = param or {}
        local totemResult, totemState = nil, nil
        if config.totem then
            totemResult, totemState = H.getTotemStates(env, cache, config.totem, param.totemSlots)
        end
        local auraResult, auraState = nil, nil
        if config.aura then
            auraResult, auraState = H.getAuraStates(env, cache, config.aura, param.unitTargets)
        end
        local r, s = H.getCoreStrategyState(
            env,
            config.strategy,
            totemState and totemState.states,
            auraState and auraState.states
        )
        if r and s and s.show then
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

    if not next(checkList) then
        -- Check all in config.
        for id, c in pairs(cache) do
            local result, state = H.getCoreState(env, cache[id], c, id, nil)
            if result and state and state.show then
                states[id] = state
                states[id].index = cache[id] and cache[id].index or 0
            end
        end
    else
        for id, param in pairs(checkList) do
            local result, state = H.getCoreState(env, cache[id], cache[id], id, param)
            if result and state and state.show then
                states[id] = state
                states[id].index = cache[id] and cache[id].index or 0
            end
        end
    end

    if not next(states) then
        return true, {
            show = false,
        }
    else
        return true, {
            show = true,
            states = states,
        }
    end
end
---------------- Trigger ------------------

---------------- Region ------------------
function H.setRegionSize(r, w, h)
    r:SetRegionWidth(w)
    r:SetRegionHeight(h)
end

function H.baseGrow(
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
            H.setRegionSize(regionData.region, width, height)
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

function H.baseSort(a, b)
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
        H.setRegionSize(regionData.region, width, height)
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

        H.baseGrow(
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
    return H.baseSort(a, b)
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
        H.setRegionSize(regionData.region, width, height)
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
    H.baseGrow(
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
    return H.baseSort(a, b)
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

    H.baseGrow(
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
    return H.baseSort(a, b)
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

    H.updateEnv()

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
