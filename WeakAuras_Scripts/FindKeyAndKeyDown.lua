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
function()
    local checker = aura_env.checker
    local config = aura_env.config
    if checker == nil or config == nil then
        return false
    end
    
    local result = false
    
    -- Check walking.
    result = checker:run(config.walking, function()
            config:feedback(config.walking)
            return true
    end) or result
    
    -- Check keydown.
    result = checker:run(config.keydown, function()
            config.keydown.changes = config.keydown.changes or {}
            local tids = {}
            local fids = {}
            for key, ids in pairs(config.keydown.ids) do
                local keydown = true
                if string.find(key, "SHIFT%-") then
                    keydown = keydown and IsShiftKeyDown()
                else
                    keydown = keydown and not IsShiftKeyDown()
                end
                if string.find(key, "ALT%-") then
                    keydown = keydown and IsAltKeyDown()
                else
                    keydown = keydown and not IsAltKeyDown()
                end
                if string.find(key, "CTRL%-") then
                    keydown = keydown and IsControlKeyDown()
                else
                    keydown = keydown and not IsControlKeyDown()
                end
                local sub = string.gsub(string.gsub(string.gsub(key, "SHIFT%-", ""), "ALT%-", ""), "CTRL%-", "")
                keydown = keydown and IsKeyDown(sub)
                if keydown then
                    for i = 1, #ids do
                        table.insert(tids, ids[i])
                    end
                else
                    for i = 1, #ids do
                        table.insert(fids, ids[i])
                    end
                end
            end
            for t = 1, #tids do
                for f = #fids, 1, -1 do
                    if tids[t] == fids[f] then
                        table.remove(fids, f)
                    end
                end
            end
            for i = 1, #tids do
                local id = tids[i]
                if not config.keydown.changes[id] then
                    config.keydown.changes[id] = true
                    config:feedback(config.keydown, id, true)
                end
            end
            for i = 1, #fids do
                local id = fids[i]
                if config.keydown.changes[id] == true then
                    config.keydown.changes[id] = false
                    config:feedback(config.keydown, id, false)
                end
            end
            return true
    end) or result
    
    return result
end
