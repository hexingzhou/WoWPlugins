--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(newPositions, activeRegions)
    if HWA and HWA.maintenanceGrow then
        local class, _ = aura_env.id:gsub("Maintenance %- HWA %- ", "")
        HWA.maintenanceGrow(newPositions, activeRegions, class)
    end
end
