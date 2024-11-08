--[[
For use:
- [Require] Replace CLASS in name to the right one.
--]]
local env = aura_env
local class = env.id:gsub("Class Options %- HWA %- ", "")

HWA = HWA or {}
HWA[class] = HWA[class] or {}

local H = HWA[class]

H.configs = H.configs or {}
H.configs["class"] = env.config
