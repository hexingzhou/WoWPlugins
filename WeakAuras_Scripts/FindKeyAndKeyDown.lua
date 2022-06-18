-- Events: SL_KEYDOWN, SL_KEYBINDING

--[[
- Conditions:
{
    keyDown = {
        display = "按下按键",
        type = "bool"
    }
}
]]--
function(allstates, event, ...)
    local spellID = 0 -- TODO: Set spellID
    if aura_env.hasBinding then
        WeakAuras.ScanEvents("SL_KEYBINDING_REGISTER", spellID)
    end

    if event == "SL_KEYDOWN" then
        local id, keyDown = ...
        if aura_env.id == id then
            allstates["KEY_BINDING"] = {
                show = true,
                changed = true,
                name = aura_env.key or "",
                keyDown = keyDown
            }
            aura_env.keyDown = keyDown
            return true
        end

    elseif event == "SL_KEYBINDING" then
        local id, key, keys = ...
        if id == spellID then
            allstates["KEY_BINDING"] = {
                show = true,
                changed = true,
                name = key,
                keyDown = aura_env.keyDown
            }
            aura_env.key = key
            aura_env.keys = keys

            if keys and next(keys) then
                WeakAuras.ScanEvents("SL_KEYDOWN_REGISTER", aura_env.id, aura_env.keys)
            else
                WeakAuras.ScanEvents("SL_KEYDOWN_UNREGISTER", aura_env.id)
            end
        end
        return true
    end

end
