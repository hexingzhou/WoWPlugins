--[[
- For use:
[Require] Replace CLASS in name to the right one.

- Run on: init
--]]
function(newPositions, activeRegions)
    if HWA and HWA.coreGrow then
        local class, _ = aura_env.id:gsub("Core %- HWA %- ", "")
        HWA.coreGrow(newPositions, activeRegions, class)
    end
end
