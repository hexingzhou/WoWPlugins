-- Run On: priority
-- For use: replace CLASS to the right one.

function(a, b)
    local HWA = HWA and HWA["CLASS"] or {}
   
    if HWA and HWA.coreSort then
        return HWA.coreSort(a, b)
    end
    return a.dataIndex <= b.dataIndex
end