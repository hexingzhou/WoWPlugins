HWA = HWA or {}
HWA.configs = HWA.configs or {}

local class, _ = aura_env.id:gsub("Class Options %- HWA %- ", "")
HWA.configs[class] = aura_env.config
