--[[
- For use:
[Require] Replace CLASS in name to the right one.
[Options] Replace Power in name to the power type making the name a unique one.

- Run on: init
--]]
function(newPositions, activeRegions)
    local H = HWA or {}
    local env = aura_env or {}

    local class, _ = env.id:gsub(".+ %- HWA %- ", "")

    if H.resourceGrow then
        H.resourceGrow(newPositions, activeRegions, class)
    end
end
