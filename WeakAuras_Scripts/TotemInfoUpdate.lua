-- Events: PLAYER_TOTEM_UPDATE
function(allstates, event, totemSlot)
    if not totemSlot then
        return false
    end

    local totemName = "" -- TODO: Set the totem name. There may be more than one totem exist at the same time.
    local chooseIndex = 1 -- Control the index of totems which will be choozen. Sorted by the expirationTime of totem.

    local totems = aura_env.totems or {}

    local exist, name, startTime, duration, icon = GetTotemInfo(totemSlot)

    if exist and name == totemName then
        local inCache = false
        for i = 1, #totems do
            local totem = totems[i]
            if totem.totemSlot == totemSlot then
                totem.duration = duration
                totem.expirationTime = startTime + duration
                inCache = true
                break
            end
            if not inCache then
                local totem = {}
                totem.totemSlot = totemSlot
                totem.duration = duration
                totem.expirationTime = startTime + duration

                table.insert(totems, totem)
            end
        end
    else
        for i = #totems, 1, -1 do
            local totem = totems[i]
            if totem.totemSlot == totemSlot then
                table.remove(totems, i)
            end
        end
    end

    table.sort(totems, function(a, b)
        return a.expirationTime > b.expirationTime
    end)

    if totems[chooseIndex] then
        allstates["TOTEM"] = {
            show = true,
            changed = true,
            autoHide = true,
            progressType = "timed",
            duration = totmes[chooseIndex].duration,
            expirationTime = totems[chooseIndex].expirationTime
        }
    else
        allstates["TOTEM"] = {
            show = false,
            changed = true
        }
    end

    aura_env.totems = totems

    return true
end
