function()
    local config = aura_env.WalkingCheck
    if config then
        SLChecker:run(config, function()
            WeakAuras:ScanEvents("SL_WALKING")
        end)
    end
end
