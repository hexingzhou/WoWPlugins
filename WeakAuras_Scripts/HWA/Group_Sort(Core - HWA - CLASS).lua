--[[
- For use:
[Require] Replace CLASS in name to the right one.

- Run on: priority
--]]
function(a, b)
    if HWA and HWA.coreSort then
        return HWA.coreSort(a, b)
    end
    return a.dataIndex < b.dataIndex
end
