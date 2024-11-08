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

local env = aura_env
local class = env.id:gsub("General Options %- HWA %- ", "")
env.class = class

local class_group = WeakAuras.GetData(env.id).parent
local dynamic_effects_group = "Dynamic Effects - HWA - " .. class
local core_group = "Core - HWA - " .. class
local left_side_group = "Left Side - HWA - " .. class
local right_side_group = "Right Side - HWA - " .. class
local maintenance_group = "Maintenance - HWA - " .. class
local resource_group = "Resource - HWA - " .. class

env.parent = class_group

HWA = HWA or {}
HWA[class] = HWA[class] or {}

local H = HWA[class]

local config = nil
H.configs = H.configs or {}
H.configs["general"] = env.config

-- Local copy.
local C_Timer = C_Timer

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

local function setRegionSize(r, w, h)
    r:SetRegionWidth(w)
    r:SetRegionHeight(h)
end

function H.getConfig(group, force)
    -- default config is set in the order as core, resouece, dynamic effects, and maintenance.
    local default = {
        core = {
            x_offset = 0,
            y_offset = 21,
            width = 41,
            height = 43,
            horizontal_spacing = 2,
            vertical_spacing = 3,
            max_icon_size_pl = 9,
            direction = 2, -- 1 for up, 2 for down
            sub_width = 33,
            sub_height = 33,
            sub_horizontal_spacing = 2,
            sub_vertical_spacing = 3,
            max_sub_icon_size_pl = 17,
            min_sub_icon_size_pl = 3,
            sub_spacing = 3,
        },
        -- resource config is used for single resource, such as power of Mana. So y_offset may be set by progress bar self.
        resource = {
            x_offset = 0,
            y_offset = 0,
            total_width = 383,
            height = 7,
            horizontal_spacing = 2,
        },
        dynamic_effects = {
            x_offset = -192,
            y_offset = 98,
            width = 41,
            height = 33,
            horizontal_spacing = 2,
            vertical_spacing = 3,
            max_icon_size_pl = 9,
            direction = 1,
            grow = 1, -- 1 for left to right, 2 for mid, 3 for right to left
        },
        maintenance = {
            x_offset = 0,
            y_offset = 541,
            width = 41,
            height = 43,
            horizontal_spacing = 2,
            vertical_spacing = 3,
            max_icon_size_pl = 13,
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
        spec = {
            -- Use SpecializationID to support different duty.
            [65] = { -- For Paladin Holy
                core = {
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                    sub_spacing = 13,
                },
                dynamic_effects = {
                    y_offset = 144,
                },
            },
            [105] = { -- For Druid Restoration
                core = {
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                },
                dynamic_effects = {
                    y_offset = 134,
                },
                form = {},
            },
            [256] = { -- For Priest Discipline
                core = {
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                },
                dynamic_effects = {
                    y_offset = 134,
                },
            },
            [257] = { -- For Priest Holy
                core = {
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                },
                dynamic_effects = {
                    y_offset = 134,
                },
            },
            [264] = { -- For Shaman Restoration
                core = {
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                },
                dynamic_effects = {
                    y_offset = 134,
                },
            },
            [270] = { -- For Monk Mistweaver
                core = {
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                },
                dynamic_effects = {
                    y_offset = 134,
                },
            },
            [1468] = { -- For Evoker Preservation
                core = {
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                    sub_spacing = 13,
                },
                dynamic_effects = {
                    y_offset = 144,
                },
            },
            [1473] = { -- For Evoker Augmentation
                core = {
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                    sub_spacing = 13,
                },
                dynamic_effects = {
                    y_offset = 144,
                },
            },
        },
    }
    local specID = 0
    local spec = GetSpecialization()
    if spec then
        specID = GetSpecializationInfo(spec) or 0
    end
    local formID = GetShapeshiftFormID() or 0
    config = config or {}
    config[specID] = config[specID] or {}
    if force or not config[specID][formID] or WeakAuras.IsOptionsOpen() then
        local c = default or {}
        local fc = c.form and c.form[formID] or {}
        local sc = c.spec and c.spec[specID] or {}
        local sfc = sc[formID] or {}
        config[specID][formID] = tmerge(c, fc, sc, sfc)

        c = H.configs["general"] or {}
        fc = c.form and c.form[formID] or {}
        sc = c.spec and c.spec[specID] or {}
        sfc = sc[formID] or {}
        config[specID][formID] = tmerge(config[specID][formID], c, fc, sc, sfc)

        c = H.configs["class"] or {}
        fc = c.form and c.form[formID] or {}
        sc = c.spec and c.spec[specID] or {}
        sfc = sc[formID] or {}
        config[specID][formID] = tmerge(config[specID][formID], c, fc, sc, sfc)
    end

    if group then
        return config[specID][formID][group] or {}
    end

    return config[specID][formID]
end

local initThrottledHandler = nil
local initThrottledLastRunTime = 0

function env.initThrottled()
    if initThrottledHandler or env.isImporting then
        return
    end

    local currentTime, delay = time(), 0.25

    if initThrottledLastRunTime > currentTime - 0.25 then
        delay = max(0.25, currentTime - initThrottledLastRunTime)
    end

    initThrottledHandler = C_Timer.NewTimer(delay, function()
        WeakAuras.ScanEvents("HWA_INIT")
    end)
end

function env.init()
    if env.isImporting then
        return
    end

    initThrottledLastRunTime = time()

    H.getConfig(nil, true)

    if initThrottledHandler then
        initThrottledHandler:Cancel()
        initThrottledHandler = nil
    end
end

hooksecurefunc("SetUIVisibility", function(isVisible)
    if isVisible and env and env.initThrottled then
        env.initThrottled()
    end
end)

local function baseGrow(newPositions, activeRegions, width, height, hSpacing, vSpacing, direction, minCount, maxCount, remainCount, growType, xOffset, yOffset)
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

    if direction < 0 then
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
    else
        local lineNumber = 1
        local currentLine = minLine
        local currentMid = 1
        if growType == 2 then
            currentMid = (currentLine + 1) / 2
        end
        local currentMin = #activeRegions - currentLine
        local y = (lineCount - 1) * (height + vSpacing) * direction + yOffset
        for i = #activeRegions, 1, -1 do
            local regionData = activeRegions[i]
            if i > currentMin then
                setRegionSize(regionData.region, width, height)
                newPositions[i] = { (i - currentMin - currentMid) * (width + hSpacing) * grow + xOffset, y }
                if i == currentMin + 1 then
                    lineNumber = lineNumber + 1
                    if lineNumber > lineCount then
                        break
                    end
                    if lineNumber == 2 then
                        currentLine = midLine
                    else
                        currentLine = maxLine
                    end
                    if growType == 2 then
                        currentMid = (currentLine + 1) / 2
                    end
                    currentMin = currentMin - currentLine
                    y = y - (height + vSpacing) * direction
                end
            end
        end
    end
end

function H.coreGrow(newPositions, activeRegions)
    local config = H.getConfig("core")
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

        local lineCount = 0
        local maxCount = config.max_sub_icon_size_pl
        local minCount = config.min_sub_icon_size_pl
        local maxLine = maxCount
        local midLine = 0
        local minLine = 0

        local remainCount = maxOverflow
        while remainCount > 0 do
            if remainCount < maxLine then
                minLine = remainCount
                remainCount = 0
                lineCount = lineCount + 1
            elseif remainCount < maxLine * 2 then
                if remainCount - maxCount < minCount then
                    midLine = remainCount - minCount
                else
                    midLine = maxCount
                end
                minLine = remainCount - midLine
                remainCount = remainCount - midLine - minLine
                lineCount = lineCount + 2
            else
                remainCount = remainCount - maxLine
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
        local currentMid = (currentLine + 1) / 2
        local currentMin = maxSize
        local currentMax = currentMin + currentLine
        local y = (subSpacing + (height - 1) / 2 + (subHeight - 1) / 2 + 1) * direction + yOffset
        for i, regionData in ipairs(activeRegions) do
            if i > currentMin then
                setRegionSize(regionData.region, subWidth, subHeight)
                newPositions[i] = { (i - currentMin - currentMid) * (subWidth + subHSpacing) + xOffset, y }
                if i == currentMax then
                    lineCount = lineCount - 1
                    if lineCount > 2 then
                        currentLine = maxLine
                    elseif lineCount > 1 then
                        currentLine = midLine
                    else
                        currentLine = minLine
                    end
                    currentMid = (currentLine + 1) / 2
                    currentMin = currentMax
                    currentMax = currentMin + currentLine
                    y = y + (subVSpacing + subHeight) * direction
                end
            end
        end
    end
end

function H.coreSort(a, b)
    local priorityA = a.region and a.region.state and a.region.state.priority or 0
    local priorityB = b.region and b.region.state and b.region.state.priority or 0
    if priorityA == priorityB then
        return a.dataIndex <= b.dataIndex
    end
    return priorityA < priorityB
end

function H.resourceGrow(newPositions, activeRegions)
    local config = H.getConfig("resource")
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

function H.dynamicEffectsGrow(newPositions, activeRegions)
    local config = H.getConfig("dynamic_effects")
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
    baseGrow(newPositions, activeRegions, width, height, hSpacing, vSpacing, direction, 0, maxSize, #activeRegions, growType, x0, yOffset)
end

function H.maintenanceGrow(newPositions, activeRegions)
    local config = H.getConfig("maintenance")
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

    baseGrow(newPositions, activeRegions, width, height, hSpacing, vSpacing, direction, 0, maxSize, #activeRegions, 2, xOffset, yOffset)
end
