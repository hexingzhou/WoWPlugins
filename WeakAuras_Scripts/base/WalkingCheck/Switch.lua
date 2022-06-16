-- Check events: PLAYER_STARTED_MOVING, PLAYER_STOPPED_MOVING

function(allstates, event)
    if not aura_env.WalkingCheck then
        local check = {}
        check.name = "WalkingCheck"
        check.enable = false
        check.count = 20
        aura_env.WalkingCheck = check
    end
    if event == "PLAYER_STARTED_MOVING" then
        print("start moving")
        aura_env.WalkingCheck.enable = true
    elseif event == "PLAYER_STOPPED_MOVING" then
        print("stop moving")
        aura_env.WalkingCheck.enable = false
    end
end
