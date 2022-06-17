-- Events: SL_KEYDOWN_REGISTER, SL_KEYDOWN_UNREGISTER
function(allstates, event, id, keys)
    local config = aura_env.config
    if event == "SL_KEYDOWN_REGISTER" then
        config.keydown:register(id, keys)
    elseif event == "SL_KEYDOWN_UNREGISTER" then
        config.keydown:unregister(id)
    end
    if config.keydown.ids and #config.keydown.ids > 0 then
        config:start(config.keydown)
    else
        config:stop(config.keydown)
    end
end
