-- For use: replace CLASS to the right one.

function(newPositions, activeRegions)
    local HWA = HWA and HWA["CLASS"] or {}
   
    if HWA and HWA.coreGrow then
        HWA.coreGrow(newPositions, activeRegions)
    end
end