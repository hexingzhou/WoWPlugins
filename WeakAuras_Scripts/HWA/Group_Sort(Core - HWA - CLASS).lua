-- Run On: priority

function(a, b)
    local HWA = HWA and HWA["CLASS"] or {}
   
    if HWA and HWA.coreSort then
        return HWA.coreSort(aura_env.child_envs, a, b)
    end
    return a.dataIndex <= b.dataIndex
end