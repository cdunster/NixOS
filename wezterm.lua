local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Frappe'
config.font = wezterm.font 'JetBrainsMono NF'

config.front_end = 'WebGpu' -- Fix weird bug where all text is shown as blocks

config.window_frame = {
    font = wezterm.font 'JetBrainsMono NF', -- The font of the tabs
}

config.window_decorations = 'NONE' -- Hide the window titlebar, NONE is the only one that works

config.colors = {
    tab_bar = {
        active_tab = {
            bg_color = '#303446',
            fg_color = '#c6d0f5',
        },
    },
}

local act = wezterm.action

config.keys = {
    {
        key = 'h',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'j',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Down',
    },
    {
        key = 'k',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'l',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Right',
    },
    {
        key = 'g',
        mods = 'ALT',
        action = act.SpawnCommandInNewTab {
            args = { 'lazygit' },
        },
    },
}

return config
