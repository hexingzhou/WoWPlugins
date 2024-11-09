--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(a, b)
    local HWA = HWA and HWA[aura_env.id:gsub("Dynamic Effects %- HWA %- ", "")] or {}
   
    if HWA and HWA.dynamicEffectsSort then
        return HWA.dynamicEffectsSort(a, b)
    end
    return a.dataIndex < b.dataIndex
end