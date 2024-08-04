local M = {}

M.config = function()
    -- Check spelling in buffer after pause instead of read/write.
    vim.g.spelunker_check_type = 2

    -- Override highlight setting.
    vim.cmd [[highlight SpelunkerSpellBad cterm=undercurl ctermfg=LightRed gui=undercurl guisp=LightRed]]
    vim.cmd [[highlight SpelunkerComplexOrCompoundWord cterm=undercurl ctermfg=LightRed gui=undercurl guisp=LightRed]]

    require("which-key").add({
        {
            { "Z",  group = "+spelunker" },
            { "Zc", desc = "Enter correction" },
            { "ZC", desc = "Enter correction for all" },
            { "Zf", desc = "Correct with first suggestion" },
            { "ZF", desc = "Correct all with first suggestion" },
            { "ZG", desc = "Add temporary good word" },
            { "Zg", desc = "Add good word" },
            { "ZL", desc = "Correct all from list" },
            { "Zl", desc = "Correct from list" },
            { "ZN", desc = "Next misspelled word" },
            { "ZP", desc = "Previous misspelled word" },
            { "ZT", desc = "Spelunker toggle" },
            { "Zt", desc = "Spelunker toggle in buffer" },
            { "ZW", desc = "Add temporary bad word" },
            { "Zw", desc = "Add bad word" },
            {
                { "Zu",  group = "+undo" },
                { "Zug", desc = "Undo adding good word" },
                { "Zuw", desc = "Undo adding bad word" },
            },
            {
                { "ZU",  group = "+undo temporary" },
                { "ZUG", desc = "Undo adding temporary good word" },
                { "ZUW", desc = "Undo adding temporary bad word" },
            },
        },

        {
            { "<leader>s",  group = "+spelunker" },
            { "<leader>sg", "<Plug>(add-spelunker-good-nmap)", desc = "Add good word" },
            { "<leader>sb", "<Plug>(add-spelunker-bad-nmap)",  desc = "Add bad word" },

            {
                { "<leader>su",  group = "+undo" },
                { "<leader>sug", "<Plug>(undo-spelunker-good-nmap)", desc = "Undo adding last good word" },
                { "<leader>sub", "<Plug>(undo-spelunker-bad-nmap)",  desc = "Undo adding last bad word" },
            },

            { "<leader>sG", "<Plug>(add-temporary-spelunker-good-nmap)", desc = "Add temporary good word" },
            { "<leader>sB", "<Plug>(add-temporary-spelunker-bad-nmap)",  desc = "Add temporary bad word" },

            {
                { "<leader>sU",  group = "+undo temporary" },
                { "<leader>sUG", "<Plug>(undo-temporary-spelunker-good-nmap)", desc = "Undo adding last temporary good word" },
                { "<leader>sUB", "<Plug>(undo-temporary-spelunker-bad-nmap)",  desc = "Undo adding last temporary bad word" },
            },

            { "<leader>sl", "<Plug>(spelunker-correct-from-list)",         desc = "Correct from list" },
            { "<leader>sL", "<Plug>(spelunker-correct-all-from-list)",     desc = "Correct all from list" },

            { "<leader>sc", "<Plug>(spelunker-correct)",                   desc = "Enter correction" },
            { "<leader>sC", "<Plug>(spelunker-correct-all)",               desc = "Enter correction for all" },

            { "<leader>sf", "<Plug>(spelunker-correct-feeling-lucky)",     desc = "Correct with first suggestion" },
            { "<leader>sF", "<Plug>(spelunker-correct-all-feeling-lucky)", desc = "Correct all with first suggestion" },

            { "<leader>sn", "<Plug>(spelunker-jump-next)",                 desc = "Jump to next bad word" },
            { "<leader>sN", "<Plug>(spelunker-jump-prev)",                 desc = "Jump to previous bad word" },

            { "<leader>st", "<Plug>(spelunker-toggle-buffer)",             desc = "Toggle spelunker in buffer" },
            { "<leader>sT", "<Plug>(spelunker-toggle)",                    desc = "Toggle spelunker" },
        },

        {
            { "]s", "<Plug>(spelunker-jump-next)", desc = "Next bad word" },
            { "[s", "<Plug>(spelunker-jump-prev)", desc = "Previous bad word" },
        },
    })
end

return M
