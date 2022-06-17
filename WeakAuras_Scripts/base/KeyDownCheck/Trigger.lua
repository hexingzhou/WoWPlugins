-- Events: SL_KEYDOWN_REGISTER, SL_KEYDOWN_UNREGISTER
function(allstates, event, id, keys)
    local config = aura_env.config
    if event == "SL_KEYDOWN_REGISTER" then
        config.keydown:register(id, keys)
    elseif event == "SL_KEYDOWN_UNREGISTER" then
        config.keydown:unregister(id)
    end
    if config.keydown.ids and next(config.keydown.ids) then
        config:start(config.keydown)
    else
        config:stop(config.keydown)
    end
end
