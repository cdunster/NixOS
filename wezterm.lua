local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Frappe'
config.font = wezterm.font 'JetBrainsMono NF'

config.front_end = 'WebGpu' -- Fix weird bug where all text is shown as blocks

config.window_frame = {
    font = wezterm.font 'JetBrainsMono NF', -- The font of the tabs
}

return config
