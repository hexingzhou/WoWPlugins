--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(a, b)
    local H = HWA or {}

    if H.dynamicEffectsSort then
        return H.dynamicEffectsSort(a, b)
    end
    
    return a.dataIndex < b.dataIndex
end
