local has_redrawn_space_connections = mods["Redrawn-Space-Connections"]
local has_interstellar_travel = mods["interstellar-travel"]
local has_dea_dia_system = mods["dea-dia-system"]
local has_metal_and_stars = mods["metal-and-stars"]

-- Throw if Redrawn is installed without Interstellar
if has_redrawn_space_connections and not has_interstellar_travel then
    error("\n\nRedrawn Space Connections is not compatible with Asteroid Belt without Interstellar Travel installed.\nPlease install Interstellar Travel from the Mod Portal.\n")
end

-- Throw if Dea Dia is installed without Interstellar
if has_dea_dia_system and not has_interstellar_travel then
    error("\n\nDea Dia System is not compatible with Asteroid Belt without Interstellar Travel installed.\nPlease install Interstellar Travel from the Mod Portal.\n")
end

-- Throw if Metal and Stars is installed without Interstellar
if has_metal_and_stars and not has_interstellar_travel then
    error("\n\nMetal and Stars is not compatible with Asteroid Belt without Interstellar Travel installed.\nPlease install Interstellar Travel from the Mod Portal.\n")
end

require("prototypes.entity")
require("prototypes.technology")
require("compatibility.interstellar-traval-early-fixes")