HWA = HWA or {}

function HWA.getPriority(c)
    if not c then return 0 end

    local specID = 0
    local spec = GetSpecialization()
    if spec then
        specID = GetSpecializationInfo(spec) or 0
    end
    local formID = GetShapeshiftFormID() or 0

    local p = c.value or 0
    local fp = c.form and c.form[formID] or 0
    if fp ~= 0 then
        p = fp
    end

    local cs = c.spec and c.spec[specID] or {}
    local sp = cs.value or 0
    if sp ~= 0 then
        p = sp
    end
    local sfp = cs.form and c.form[formID] or 0
    if sfp ~= 0 then
        p = sfp
    end

    return p
end