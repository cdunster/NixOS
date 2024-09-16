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
        key = 'LeftArrow',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'DownArrow',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Down',
    },
    {
        key = 'UpArrow',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'RightArrow',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Right',
    },
    {
        key = 's',
        mods = 'ALT',
        action = act.SplitHorizontal {},
    },
    {
        key = 'v',
        mods = 'ALT',
        action = act.SplitPane {
            direction = 'Down',
            size = { Percent = 30 },
        },
    },
    {
        key = 'z',
        mods = 'ALT',
        action = act.TogglePaneZoomState,
    },
    {
        key = 'g',
        mods = 'ALT',
        action = act.SpawnCommandInNewTab {
            args = { 'lazygit' },
        },
    },
    -- Prompt for a name to use for a new workspace and switch to it.
    {
        key = 'n',
        mods = 'ALT',
        action = act.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = 'Enter name for new workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:perform_action(
                        act.SwitchToWorkspace {
                            name = line,
                        },
                        pane
                    )
                end
            end),
        },
    },
    -- List all workspaces in the launcher and allow activating one.
    {
        key = 'w',
        mods = 'ALT',
        action = act.ShowLauncherArgs {
            flags = 'FUZZY | WORKSPACES',
        },
    },
}

return config
