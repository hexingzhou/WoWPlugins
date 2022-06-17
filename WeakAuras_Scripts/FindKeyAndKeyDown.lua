-- Events: ACTIONBAR_SLOT_CHANGED, UPDATE_BINDINGS, SL_KEYDOWN

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
                name = aura_env.key,
                keyDown = keyDown
            }
            aura_env.keyDown = keyDown
            return true
        end
        
    else
        local spellID = 0 -- TODO: Set spellID
        local key = ""
        local hasBinding = false
        local keys = {}
        
        local slots = C_ActionBar.FindSpellActionButtons(spellID)
        if slots then
            for i = 1, #slots do
                local slot = slots[i]
                local key1, key2
                if slot < 13 then
                    key1, key2 = GetBindingKey("ACTIONBUTTON"..slot)
                elseif slot < 25 then
                    key1, key2 = GetBindingKey("ELVUIBAR2BUTTON"..(slot - 12))
                elseif slot < 37 then
                    key1, key2 = GetBindingKey("MULTIACTIONBAR3BUTTON"..(slot - 24))
                elseif slot < 49 then
                    key1, key2 = GetBindingKey("MULTIACTIONBAR4BUTTON"..(slot - 36))
                end
                
                if key1 then
                    if hasBinding then
                        key = key.."/"..key1
                    else
                        key = key1
                        hasBinding = true
                    end
                    table.insert(keys, key1)
                elseif key2 then
                    if hasBinding then
                        key = key.."/"..key2
                    else
                        key = key2
                        hasBinding = true
                    end
                    table.insert(keys, key2)
                end
            end
        end
        
        aura_env.keys = keys
        
        if key then
            key = string.gsub(string.gsub(string.gsub(key, "SHIFT%-", "S"), "ALT%-", "A"), "CTRL%-", "C")
            allstates["KEY_BINDING"] = {
                show = true,
                changed = true,
                name = key,
                keyDown = aura_env.keyDown
            }
            WeakAuras.ScanEvents("SL_KEYDOWN_REGISTER", aura_env.id, aura_env.keys)
        else
            allstates["KEY_BINDING"] = {
                show = true,
                changed = true,
                name = nil,
                keyDown = aura_env.keyDown
            }
            WeakAuras.ScanEvents("SL_KEYDOWN_UNREGISTER", aura_env.id)
        end
        aura_env.key = key
        
        return true
    end
    
end
