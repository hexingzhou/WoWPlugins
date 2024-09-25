-- Events: PLAYER_TOTEM_UPDATE

--[[
- Conditions:
{
    expirationTime = true,
    duration = true
}
]]--
function(states, event, totemSlot)
    if not totemSlot then
        return false
    end

    local key = "TOTEM"

    -- There may be more than one totem exist at the same time.
    local name = aura_env.totem and aura_env.totem.name or ""
    if name == "" then
        name = aura_env.id:gsub(" %- %d+", "")
    end

    local totems = aura_env.totems or {}

    local haveTotem, totemName, startTime, duration, icon = GetTotemInfo(totemSlot)

    if haveTotem and name == totemName then
        local inCache = false
        for i = 1, #totems do
            local totem = totems[i]
            if totem.totemSlot == totemSlot then
                totem.duration = duration
                totem.expirationTime = startTime + duration
                inCache = true
                break
            end
        end
        if not inCache then
            local totem = {}
            totem.totemSlot = totemSlot
            totem.duration = duration
            totem.expirationTime = startTime + duration

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

    -- Sorted by the expirationTime of totem. The first totem will be choozen.
    table.sort(totems, function(a, b)
        return a.expirationTime > b.expirationTime
    end)

    if totems[1] then
        allstates[key] = {
            show = true,
            changed = true,
            autoHide = true,
            progressType = "timed",
            duration = totems[1].duration,
            expirationTime = totems[1].expirationTime,
            stacks = #totems
        }
    else
        allstates[key] = {
            show = false,
            changed = true
        }
    end

    aura_env.totems = totems

    return true
end
