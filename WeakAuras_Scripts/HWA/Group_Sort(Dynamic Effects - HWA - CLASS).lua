--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(a, b)
    if HWA and HWA.dynamicEffectsSort then
        return HWA.dynamicEffectsSort(a, b)
    end
    return a.dataIndex < b.dataIndex
end
