local M = {}

M.config = function()
    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { { 'filetype', icon_only = true, colored = false }, { 'filename', path = 1 }, 'diagnostics' },
            lualine_c = { 'lsp_progress' },
            lualine_x = {},
            lualine_y = { 'diff', 'branch' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = { 'mode' },
            lualine_b = { { 'filetype', icon_only = true, colored = false }, { 'filename', path = 1 }, 'diagnostics' },
            lualine_c = { 'lsp_progress' },
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' }
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
end

return M;
