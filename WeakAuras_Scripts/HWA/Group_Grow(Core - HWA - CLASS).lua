--[[
- For use:
[Require] Replace CLASS in name to the right one.

- Run on: init
--]]
function(newPositions, activeRegions)
    local H = HWA or {}
    local env = aura_env or {}

    local class, _ = env.id:gsub("Core %- HWA %- ", "")

    if H.coreGrow then
        H.coreGrow(newPositions, activeRegions, class)
    end
end
