--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(newPositions, activeRegions)
    local H = HWA or {}
    local env = aura_env or {}

    local class, _ = env.id:gsub("Dynamic Effects %- HWA %- ", "")

    if H.dynamicEffectsGrow then
        H.dynamicEffectsGrow(newPositions, activeRegions, class)
    end
end
