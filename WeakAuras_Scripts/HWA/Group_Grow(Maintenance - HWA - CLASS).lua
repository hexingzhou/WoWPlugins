--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(newPositions, activeRegions)
    local HWA = HWA and HWA[aura_env.id:gsub("Maintenance %- HWA %- ", "")] or {}
   
    if HWA and HWA.maintenanceGrow then
        HWA.maintenanceGrow(newPositions, activeRegions)
    end
end