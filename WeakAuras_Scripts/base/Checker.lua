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
        for key, ids in pairs(config.keydown.ids) do
            if IsKeyDown(key) then
                for i = 1, #ids do
                    config:feedback(config.keydown, ids[i])
                end
            end
        end
        return true
    end) or result

    return result
end
