--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(newPositions, activeRegions)
    if HWA and HWA.maintenanceGrow then
        HWA.maintenanceGrow(newPositions, activeRegions, aura_env.id:gsub("Maintenance %- HWA %- ", ""))
    end
end
