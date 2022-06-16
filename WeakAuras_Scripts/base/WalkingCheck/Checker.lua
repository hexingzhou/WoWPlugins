function()
    local config = aura_env.WalkingCheck
    if config then
        aura_env.checker:run(config, function()
                WeakAuras.ScanEvents("SL_WALKING")
                return true
        end)
    end
end
