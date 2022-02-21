local M = {}

M.config = function()
    require("gitsigns").setup({
        current_line_blame = true,
        keymaps = { }, -- Remove default keymaps.
    })

    local wk = require("which-key")
    wk.register({
        ["]g"] = { "<cmd>lua require('gitsigns.actions').next_hunk()<CR>", "Next git hunk" },
        ["[g"] = { "<cmd>lua require('gitsigns.actions').prev_hunk()<CR>", "Previous git hunk" },
    })

    wk.register({
        ["ih"] = { ":<C-U>lua require('gitsigns.actions').select_hunk()<CR>", "Select git hunk" },
    }, { mode = "o" })

    wk.register({
        ["ih"] = { ":<C-U>lua require('gitsigns.actions').select_hunk()<CR>", "Select git hunk" },
    }, { mode = "x" })

    wk.register({
        name = "+git",
        ["s"] = { "<cmd>lua require('gitsigns').stage_hunk()<CR>", "Stage current hunk" },
        ["S"] = { "<cmd>lua require('gitsigns').stage_buffer()<CR>", "Stage current buffer" },
        ["u"] = { "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", "Undo staging last hunk" },
        ["r"] = { "<cmd>lua require('gitsigns').reset_hunk()<CR>", "Reset current hunk" },
        ["R"] = { "<cmd>lua require('gitsigns').reset_buffer()<CR>", "Reset current buffer" },
        ["p"] = { "<cmd>lua require('gitsigns').preview_hunk()<CR>", "Preview current hunk" },
    }, { prefix = "<leader>g" })

    wk.register({
        name = "+git",
        ["s"] = { "<cmd>lua require('gitsigns').stage_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>", "Stage selected hunk(s)" },
        ["r"] = { "<cmd>lua require('gitsigns').reset_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>", "Reset selected hunk(s)" },
    }, { mode = "v", prefix = "<leader>g" })
end

return M
