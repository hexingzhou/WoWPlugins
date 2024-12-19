--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(a, b)
    local H = HWA or {}

    if H.maintenanceSort then
        return H.maintenanceSort(a, b)
    end
    
    return a.dataIndex < b.dataIndex
end
