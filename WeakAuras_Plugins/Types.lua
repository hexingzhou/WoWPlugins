--[[
Replace code in local simpleFormatters.
--]]
local simpleFormatters = {
    -- ...
    time = {
        -- ...
        [0] = function(value)
            if type(value) == "string" then
                value = tonumber(value)
            end
            if type(value) == "number" then
                if value > 60 then
                    return string.format("%i", math.floor(value / 60) + 1) .. "m"
                else
                    return string.format("%d", value)
                end
            end
        end,
        -- ...
    },
    -- ...
}
