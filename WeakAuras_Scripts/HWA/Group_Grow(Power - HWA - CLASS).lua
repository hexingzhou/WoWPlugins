--[[
- For use:
[Require] Replace CLASS in name to the right one.
[Options] Replace Power in name to the power type making the name a unique one.

- Run on: init
--]]
function(newPositions, activeRegions)
    if HWA and HWA.resourceGrow then
        local class, _ = aura_env.id:gsub(".+ %- HWA %- ", "")
        HWA.resourceGrow(newPositions, activeRegions, class)
    end
end
