local SL = aura_env

SL.checker = {}

function SL.checker:run(config, check)
    if not config or not config.name then
        return false
    end
    self[config.name] = self[config.name] or {}
    local env = self[config.name]
    if config.enable then
        local count = config.count or 100
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

--[[
Config of all features:
- walking: Check walking state of the character.
           Use event SL_WALKING to send feedback.
- keydown: Check key down from keyboard.
           Use events SL_KEYDOWN_REGISTER and SL_KEYDOWN_UNREGISTER to set keys for check.
           Use event SL_KEYDOWN to send feedback.

Config info:
- name: Identity of the config.
- count: To control the frequency of check jobs.
         The number is bigger, less times of check job will be, and cost less resources of system.
- event: The event used to send feedback. See function SL.config:feedback.
- enable: Whether or not to enable check job.
]]--
SL.config = {
    walking = {
        name = "WalkingCheck",
        count = 20,
        event = "SL_WALKING",
        enable = false
    },
    keydown = {
        name = "KeyDownCheck",
        count = 20,
        event = "SL_KEYDOWN",
        enable = false
    }
}

-- Start check for feature. Use feature config as the parameter.
function SL.config:start(config)
    config.enable = true
end

-- Stop check for feature. Use feature config as the parameter.
function SL.config:stop(config)
    config.enable = false
end

-- Send feedback for feature.
function SL.config:feedback(config, ...)
    WeakAuras.ScanEvents(config.event, ...)
end


-- Feature keydown.
function SL.config.keydown:register(id, keys)
    if not id or not keys then
        return
    end
    self.keys = self.keys or {}
    self.ids = self.ids or {}

    -- First remove keys.
    self:unregister(id)

    self.keys[id] = keys
    for i = 1, #keys do
        local key = keys[i]
        local ids = self.ids[key] or {}
        local exist = false
        for index, value in ipairs(tab) do
            if value == val then
                exist = true
            end
        end
        if not exist then
            table.insert(ids, id)
        end
        self.ids[key] = ids
    end
end

function SL.config.keydown:unregister(id)
    if not id then
        return
    end
    self.keys = self.keys or {}
    self.ids = self.ids or {}

    local keys = self.keys[id] or {}
    for i = 1, #keys do
        local key = keys[i]
        local ids = self.ids[key] or {}
        for index = #ids, 1, -1 do
            if id == ids[index] then
                table.remove(ids, index)
            end
        end
        self.ids[key] = ids
    end
    self.keys[id] = nil
end
