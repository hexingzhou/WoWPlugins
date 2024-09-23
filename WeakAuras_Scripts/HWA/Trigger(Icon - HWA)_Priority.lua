-- HWA_INIT

function(event, ...)
    return true
end


------------------------------------
-- Condition: Trigger Active
local state = aura_env.state
if state and HWA and HWA.getPriority then
    state.priority = HWA.getPriority()
end