-- Events: SL_KEYBINDING_REGISTER, SL_KEYBINDING_UNREGISTER, ACTIONBAR_SLOT_CHANGED, UPDATE_BINDINGS
function(allstates, event, id, type)
    local checker = aura_env.checker
    local config = aura_env.config
    if event == "SL_KEYBINDING_REGISTER" then
        if config.keybinding:register(id, type) then
            config.keybinding:check(id, type)
        end
    elseif event == "SL_KEYBINDING_UNREGISTER" then
        if config.keybinding:unregister(id) then
            config:feedback(config.keybinding, id, "", {})
        end
    elseif event == "ACTIONBAR_SLOT_CHANGED" or event == "UPDATE_BINDINGS" then
        if config.keybinding.ids then
            for i, t in pairs(config.keybinding.ids) do
                if i and t then
                    config.keybinding:check(i, t)
                end
            end
        end
    end
end
