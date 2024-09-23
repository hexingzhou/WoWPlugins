-- CLASS identifier follows https://wowpedia.fandom.com/wiki/API_UnitClass.
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
        if WeakAuras.IsImporting() or not env.IsImporting then return end

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
    local ts = {...}
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
            sub_spacing = 3
        },
        form = {
            -- Use ShapeshiftFormID to support different form.
            [1] = { -- For Druid Cat Form
                core = {

                }
            },
            [5] = { -- For Druid Bear Form
                core = {

                }
            }
        },
        spec = {
            -- Use SpecializationID to support different duty.
            [65] = { -- For Paladin Holy
                core = {
                    y_offset = 16,
                    width = 33,
                    height = 33,
                    max_icon_size_pl = 11,
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                    sub_spacing = 13
                }
            },
            [105] = { -- For Druid Restoration
                core = {
                    y_offset = 16,
                    width = 33,
                    height = 33,
                    max_icon_size_pl = 11,
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                    sub_spacing = 13
                },
                form = {

                }
            },
            [256] = { -- For Priest Discipline
                core = {
                    y_offset = 16,
                    width = 33,
                    height = 33,
                    max_icon_size_pl = 11,
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                    sub_spacing = 13
                }
            },
            [257] = { -- For Priest Holy
                core = {
                    y_offset = 16,
                    width = 33,
                    height = 33,
                    max_icon_size_pl = 11,
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                    sub_spacing = 13
                }
            },
            [264] = { -- For Shaman Restoration
                core = {
                    y_offset = 16,
                    width = 33,
                    height = 33,
                    max_icon_size_pl = 11,
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                    sub_spacing = 13
                }
            },
            [270] = { -- For Monk Mistweaver
                core = {
                    y_offset = 16,
                    width = 33,
                    height = 33,
                    max_icon_size_pl = 11,
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                    sub_spacing = 13
                }
            },
            [1468] = { -- For Evoker Preservation
                core = {
                    y_offset = 16,
                    width = 33,
                    height = 33,
                    max_icon_size_pl = 11,
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                    sub_spacing = 13
                }
            },
            [1473] = { -- For Evoker Augmentation
                core = {
                    y_offset = 16,
                    width = 33,
                    height = 33,
                    max_icon_size_pl = 11,
                    direction = 1,
                    max_sub_icon_size_pl = 11,
                    sub_spacing = 13
                }
            }
        }
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
    if initThrottledHandler or env.isImporting then return end

    local currentTime, delay = time(), 0.25

    if initThrottledLastRunTime > currentTime - 0.25 then
        delay = max(0.25, currentTime - initThrottledLastRunTime)
    end

    initThrottledHandler = C_Timer.NewTimer(delay, function()
        WeakAuras.ScanEvents("HWA_INIT")
    end)
end


function env.init()
    if env.isImporting then return end

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
        newPositions[i] = { (i - mid) * (width + hSpacing) + xOffset, yOffset}
        if i == maxSize then break end
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
        while (remainCount > 0) do
            if remainCount < maxLine then
                minLine = remainCount
                remainCount = remainCount - minLine
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


local function getPriority(c)
    if not c then return 0 end

    local specID = 0
    local spec = GetSpecialization()
    if spec then
        specID = GetSpecializationInfo(spec) or 0
    end
    local formID = GetShapeshiftFormID() or 0

    local p = c.value or 0
    p = min(c.form and c.form[formID] or 0, p)

    local cs = c.spec and c.spec[specID] or {}
    p = min(cs.value or 0, p)
    p = min(cs.form and c.form[formID] or 0, p)

    return p
end


function H.coreSort(envs, a, b)
    local priorityA = getPriority(envs[a.dataIndex] and envs[a.dataIndex].priority or {})
    local priorityB = getPriority(envs[b.dataIndex] and envs[b.dataIndex].priority or {})
    if priorityA == priorityB then
        return a.dataIndex <= b.dataIndex
    end
    return priorityA < priorityB
end
