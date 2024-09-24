-- Events: PLAYER_STARTED_MOVING, PLAYER_STOPPED_MOVING

function(allstates, event)
    local config = aura_env.config
    if event == "PLAYER_STARTED_MOVING" then
        config:start(config.walking)
    elseif event == "PLAYER_STOPPED_MOVING" then
        config:stop(config.walking)
    end
end
