HWA = HWA or {}

function HWA.getPriority()
    local p = HWA.priority or 0
    if p > 100000 then
        p = 0
    end
    HWA.priority = p + 1
    return p
end