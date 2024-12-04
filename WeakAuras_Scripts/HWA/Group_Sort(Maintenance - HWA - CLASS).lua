--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(a, b)
    if HWA and HWA.maintenanceSort then
        return HWA.maintenanceSort(a, b)
    end
    return a.dataIndex < b.dataIndex
end
