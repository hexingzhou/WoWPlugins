-- Events: SL_KEYDOWN, SL_KEYBINDING_INIT, SL_KEYBINDING

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
    local type = 1 -- For spell, type = 1

    -- This WA has not loaded.
    if not aura_env.init then
        WeakAuras.ScanEvents("SL_KEYBINDING_REGISTER", spellID, type)
        aura_env.init = true
    end

    if event == "SL_KEYBINDING_INIT" then
        WeakAuras.ScanEvents("SL_KEYBINDING_REGISTER", spellID, type)
    elseif event == "SL_KEYDOWN" then
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
