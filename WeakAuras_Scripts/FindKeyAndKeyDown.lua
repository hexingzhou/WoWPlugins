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
        local spellIDs = {} -- TODO: Set spellIDs
        local type = 1 -- For spell, type = 1

        local id, key, keys = ...

        -- This WA has not loaded.
        if not id then
            for i = 1, #spellIDs do
                WeakAuras.ScanEvents("SL_KEYBINDING_REGISTER", spellIDs[i], type)
            end
        end

        for i = 1, #spellIDs do
            if id == spellIDs[i] then
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
        end

        return true
    end

end
