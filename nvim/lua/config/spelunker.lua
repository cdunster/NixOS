local M = {}

M.config = function()

    -- Check spelling in buffer after pause instead of read/write.
    vim.g.spelunker_check_type = 2

    -- Override highlight setting.
    vim.cmd[[highlight SpelunkerSpellBad cterm=undercurl ctermfg=LightRed gui=undercurl guisp=LightRed]]
    vim.cmd[[highlight SpelunkerComplexOrCompoundWord cterm=undercurl ctermfg=LightRed gui=undercurl guisp=LightRed]]

    local wk = require("which-key")
    wk.register({
        name = "+spelunker",
        ["c"] = "Enter correction",
        ["C"] = "Enter correction for all",
        ["f"] = "Correct with first suggestion",
        ["F"] = "Correct all with first suggestion",
        ["G"] = "Add temporary good word",
        ["g"] = "Add good word",
        ["L"] = "Correct all from list",
        ["l"] = "Correct from list",
        ["N"] = "Next misspelled word",
        ["P"] = "Previous misspelled word",
        ["T"] = "Spelunker toggle",
        ["t"] = "Spelunker toggle in buffer",
        ["W"] = "Add temporary bad word",
        ["w"] = "Add bad word",
        ["u"] = {
            name = "+undo",
            ["g"] = "Undo adding good word",
            ["w"] = "Undo adding bad word",
        },
        ["U"] = {
            name = "+undo temporary",
            ["G"] = "Undo adding temporary good word",
            ["W"] = "Undo adding temporary bad word",
        },
    }, { prefix = "Z" })

    wk.register({
        name = "+spelunker",
        ["g"] = { "<Plug>(add-spelunker-good-nmap)", "Add good word" },
        ["b"] = { "<Plug>(add-spell-bad-nmap)", "Add bad word" },
        ["u"] = {
            name = "+undo",
            ["g"] = { "<Plug>(undo-spelunker-good-nmap)", "Undo adding last good word" },
            ["b"] = { "<Plug>(undo-spelunker-bad-nmap)", "Undo adding last bad word" },
        },
        ["G"] = { "<Plug>(add-temporary-spelunker-good-nmap)", "Add temporary good word" },
        ["B"] = { "<Plug>(add-temporary-spelunker-bad-nmap)", "Add temporary bad word" },
        ["U"] = {
            name = "+undo temporary",
            ["G"] = { "<Plug>(undo-temporary-spelunker-good-nmap)", "Undo adding last temporary good word" },
            ["B"] = { "<Plug>(undo-temporary-spelunker-bad-nmap)", "Undo adding last temporary bad word" },
        },

        ["l"] = { "<Plug>(spelunker-correct-from-list)", "Correct from list" },
        ["L"] = { "<Plug>(spelunker-correct-all-from-list)", "Correct all from list" },

        ["c"] = { "<Plug>(spelunker-correct)", "Enter correction" },
        ["C"] = { "<Plug>(spelunker-correct-all)", "Enter correction for all" },

        ["f"] = { "<Plug>(spelunker-correct-feeling-lucky)", "Correct with first suggestion" },
        ["F"] = { "<Plug>(spelunker-correct-all-feeling-lucky)", "Correct all with first suggestion" },

        ["n"] = { "<Plug>(spelunker-jump-next)", "Jump to next bad word" },
        ["N"] = { "<Plug>(spelunker-jump-prev)", "Jump to previous bad word" },

        ["t"] = { "<Plug>(spelunker-toggle-buffer)", "Toggle spelunker in buffer" },
        ["T"] = { "<Plug>(spelunker-toggle)", "Toggle spelunker" },
    }, { prefix = "<leader>s" })

    wk.register({
        ["]s"] = { "<Plug>(spelunker-jump-next)", "Next bad word" },
        ["[s"] = { "<Plug>(spelunker-jump-prev)", "Previous bad word" },
    })
end

return M
