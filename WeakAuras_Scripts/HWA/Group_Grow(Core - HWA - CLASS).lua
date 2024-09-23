function(newPositions, activeRegions)
    local HWA = HWA and HWA["CLASS"] or {}
   
    if HWA and HWA.coreGrow then
        HWA.coreGrow(newPositions, activeRegions)
    end
end