-- For use: replace CLASS to the right one.

function(newPositions, activeRegions)
    local HWA = HWA and HWA["CLASS"] or {}
   
    if HWA and HWA.dynamicEffectsGrow then
        HWA.dynamicEffectsGrow(newPositions, activeRegions)
    end
end