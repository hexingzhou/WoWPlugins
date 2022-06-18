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
           - SL_KEYDOWN_REGISTER, id, keys
           - SL_KEYDOWN_UNREGISTER, id
           Use event SL_KEYDOWN to send feedback.
           - SL_KEYDOWN, id
- keybinding: Check binding key from spellID.
              Use events SL_KEYBINDING_REGISTER and SL_KEYBINDING_UNREGISTER to set spellIDs for check.
              - SL_KEYBINDING_REGISTER, id, type
              - SL_KEYDOWN_UNREGISTER, id
              Use event SL_KEYBINDING to send feedback.
              - SL_KEYBINDING, id, key, keys

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
        feedback_event = "SL_WALKING",
        enable = false
    },
    keydown = {
        name = "KeyDownCheck",
        count = 0,
        feedback_event = "SL_KEYDOWN",
        enable = false
    },
    keybinding = {
        name = "KeyBindingCheck",
        count = 0,
        feedback_event = "SL_KEYBINDING",
        enable = true
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
    WeakAuras.ScanEvents(config.feedback_event, ...)
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
        for index, value in ipairs(ids) do
            if value == id then
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


-- Feature keybinding.
function SL.config.keybinding:register(id, type)
    if not id or not type then
        return false
    end
    self.ids = self.ids or {}
    if not self.ids[id] then
        self.ids[id] = type
        return true
    end
    return false
end

function SL.config.keybinding:unregister(id)
    if not id then
        return false
    end
    self.ids = self.ids or {}
    if self.ids[id] then
        self.ids[id] = nil
        return true
    end
    return false
end

function SL.config.keybinding:check(id, type)
    -- TODO: Only check spellID. Support item...
    if not id or not type then
        return
    end
    local config = SL.config
    local key = ""
    local hasBinding = false
    local keys = {}

    local slots = self:findActionButtons(id, type)
    if slots then
        for i = 1, #slots do
            local slot = slots[i]
            local key1, key2
            if slot < 13 then
                key1, key2 = GetBindingKey("ACTIONBUTTON"..slot)
            elseif slot < 25 then
                key1, key2 = GetBindingKey("ELVUIBAR2BUTTON"..(slot - 12))
            elseif slot < 37 then
                key1, key2 = GetBindingKey("MULTIACTIONBAR3BUTTON"..(slot - 24))
            elseif slot < 49 then
                key1, key2 = GetBindingKey("MULTIACTIONBAR4BUTTON"..(slot - 36))
            end

            if key1 then
                if hasBinding then
                    key = key.."/"..key1
                else
                    key = key1
                    hasBinding = true
                end
                table.insert(keys, key1)
            elseif key2 then
                if hasBinding then
                    key = key.."/"..key2
                else
                    key = key2
                    hasBinding = true
                end
                table.insert(keys, key2)
            end
        end
    end

    if key then
        key = string.gsub(string.gsub(string.gsub(key, "SHIFT%-", "S"), "ALT%-", "A"), "CTRL%-", "C")
    end
    config:feedback(config.keybinding, id, key, keys)
end

function SL.config.keybinding:findActionButtons(id, type)
    if not id or not type then
        return {}
    end
    if type == 1 then
        return C_ActionBar.FindSpellActionButtons(id)
    elseif type == 2 then
        local slots = {}
        for i = 1, 120 do
            local actionType, actionId, actionSubType = GetActionInfo(i)
            if actionType == "item" and id == actionId then
                table.insert(slots, i)
            end
        end
        return slots
    end
    return {}
end
