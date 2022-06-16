local SLChecker = {}
function SLChecker:run(config, check)
    if not config or not config.name then
        return false
    end
    self[config.name] = self[config.name] or {}
    local env = self[config.name]
    if config.enable then
        local count = config.count or 10
        env.count = env.count or 0
        if env.count < count then
            env.count = env.count + 1
        else
            env.count = 0
            return check()
        end
    end
    return false
end
