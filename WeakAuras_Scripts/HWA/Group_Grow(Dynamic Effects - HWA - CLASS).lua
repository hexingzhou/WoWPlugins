--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(newPositions, activeRegions)
    if HWA and HWA.dynamicEffectsGrow then
        local class, _ = aura_env.id:gsub("Dynamic Effects %- HWA %- ", "")
        HWA.dynamicEffectsGrow(newPositions, activeRegions, class)
    end
end
