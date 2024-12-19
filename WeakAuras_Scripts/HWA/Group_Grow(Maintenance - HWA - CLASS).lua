--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(newPositions, activeRegions)
    local H = HWA or {}
    local env = aura_env or {}

    local class, _ = env.id:gsub("Maintenance %- HWA %- ", "")

    if H.maintenanceGrow then
        H.maintenanceGrow(newPositions, activeRegions, class)
    end
end
