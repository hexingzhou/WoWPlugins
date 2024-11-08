--[[
- For use:
[Require] Replace CLASS in name to the right one.
[Options] Replace Power in name to the power type making the name a unique one.
--]]
function(newPositions, activeRegions)
    local HWA = HWA and HWA[aura_env.id:gsub(".+ %- HWA %- ", "")] or {}
   
    if HWA and HWA.resourceGrow then
        HWA.resourceGrow(newPositions, activeRegions)
    end
end