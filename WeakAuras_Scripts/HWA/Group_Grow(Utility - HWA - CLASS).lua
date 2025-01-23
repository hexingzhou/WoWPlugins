--[[
- For use:
[Require] Replace CLASS in name to the right one.

- Run on: init
--]]
function(newPositions, activeRegions)
    local H = HWA or {}
    local env = aura_env or {}

    local class, _ = env.id:gsub("Utility %- HWA %- ", "")

    if H.utilityGrow then
        H.utilityGrow(newPositions, activeRegions, class)
    end
end
