--[[
- For use:
[Require] Replace CLASS in name to the right one.

- Run on: priority
--]]
function(a, b)
    local H = HWA or {}

    if H.utilitySort then
        return H.utilitySort(a, b)
    end
    
    return a.dataIndex < b.dataIndex
end
