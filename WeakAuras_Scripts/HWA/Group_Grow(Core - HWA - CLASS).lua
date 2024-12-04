--[[
- For use:
[Require] Replace CLASS in name to the right one.

- Run on: init
--]]
function(newPositions, activeRegions)
    if HWA and HWA.coreGrow then
        HWA.coreGrow(newPositions, activeRegions, aura_env.id:gsub("Core %- HWA %- ", ""))
    end
end
