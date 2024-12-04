--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(newPositions, activeRegions)
    if HWA and HWA.dynamicEffectsGrow then
        HWA.dynamicEffectsGrow(newPositions, activeRegions, aura_env.id:gsub("Dynamic Effects %- HWA %- ", ""))
    end
end
