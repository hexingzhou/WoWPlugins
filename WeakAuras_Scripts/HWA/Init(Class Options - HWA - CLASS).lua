local H = HWA or {}
local env = aura_env or {}

local class, _ = env.id:gsub("Class Options %- HWA %- ", "")

H.configs = H.configs or {}
H.configs[class] = env.config
