--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(newPositions, activeRegions)
    local HWA = HWA and HWA[aura_env.id:gsub("Core %- HWA %- ", "")] or {}
   
    if HWA and HWA.coreGrow then
        HWA.coreGrow(newPositions, activeRegions)
    end
end