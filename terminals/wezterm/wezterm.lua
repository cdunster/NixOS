local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Frappe'                 -- Use the built-in Catppuccin colour scheme
config.font = wezterm.font 'JetBrainsMono NF'             -- Use the JetBrainsMono Nerd Font system font
config.front_end = 'WebGpu'                               -- Fix weird bug where all text is shown as blocks
config.window_frame = {
    font = wezterm.font 'JetBrainsMono NF',               -- The font of the tab title
}
config.window_decorations = "TITLE | RESIZE"              -- Hide the window titlebar
config.adjust_window_size_when_changing_font_size = false -- Using a tiling WM so window should stay a fixed size
config.colors = {
    tab_bar = {
        active_tab = {
            bg_color = '#303446', -- Use the Catppuccin Frappe background colour for the tab background
            fg_color = '#c6d0f5', -- Use the Catppuccin Frappe foreground colour for the tab foreground / title text
        },
    },
}

local act = wezterm.action
config.keys = {
    {
        -- Disable default binding to enter full screen mode.
        key = 'Enter',
        mods = 'ALT',
        action = act.DisableDefaultAssignment,
    },
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
    {
        key = 'n',
        mods = 'ALT | SHIFT',
        action = act.SwitchToWorkspace {
            name = 'notes',
            spawn = {
                args = { 'nvim', '-S' },
                cwd = '/home/callum/repos/notes',
            },
        },
    },
    {
        -- Prompt for a name to use for a new workspace and switch to it.
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
                            spawn = { cwd = '/home/callum' },
                        },
                        pane
                    )
                end
            end),
        },
    },
    {
        -- List all workspaces in the launcher and allow activating one.
        key = 'w',
        mods = 'ALT',
        action = act.ShowLauncherArgs {
            flags = 'FUZZY | WORKSPACES',
        },
    },
}

return config
