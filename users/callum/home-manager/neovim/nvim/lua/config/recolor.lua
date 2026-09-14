local M = {}

function M.apply()
    local palette = require('stylix_palette')
    require('mini.base16').setup({ palette = palette.base16 })
    vim.api.nvim_set_hl(0, 'Comment', { fg = palette.overrides.comment })
    vim.api.nvim_set_hl(0, 'Whitespace', { fg = palette.overrides.whitespace })
    vim.api.nvim_set_hl(0, 'Delimiter', { fg = palette.overrides.delimiter })

    -- gitsigns derives its "staged" hunk highlights by combining colours the
    -- first time they're needed so they need to be cleared for the new colours
    -- to take effect.
    local ok, gs_highlight = pcall(require, 'gitsigns.highlight')
    if ok then
        for _, hlgroup in ipairs(gs_highlight.hls) do
            for hl in pairs(hlgroup) do
                if hl:match('^GitSignsStaged') then
                    vim.api.nvim_set_hl(0, hl, {})
                end
            end
        end
    end

    -- mini.base16 (used by Stylix) doesn't trigger this as it's not a real
    -- colour scheme but plugins like lualine and gitsigns require it to update
    -- their colours
    vim.api.nvim_exec_autocmds('ColorScheme', {})
end

-- Called remotely after a specialisation switch so drop the cached palette
-- module causing it to be re-read from disk.
function M.reload()
    package.loaded['stylix_palette'] = nil
    M.apply()
end

return M
