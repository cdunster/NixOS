local palette = require('stylix_palette')
require('mini.base16').setup({ palette = palette })

vim.api.nvim_set_hl(0, 'Comment', { fg = palette.base04 })
vim.api.nvim_set_hl(0, 'Whitespace', { fg = palette.base0F })
vim.api.nvim_set_hl(0, 'Delimiter', { fg = palette.base03 })

-- gitsigns derives some highlights the first time they're used, so clear the
-- cached ones so the new colours can be created
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

vim.g.colors_name = 'stylix'
