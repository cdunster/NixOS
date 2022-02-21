local M = {}

M.config = function()
    require("nvim-treesitter.configs").setup {
        indent = { enable = true },
        highlight = { enable = true },
        textobjects = {
            select = {
                enable = true,
                -- Automatically jump forward to textobj.
                lookahead = true,
                keymaps = {
                    -- Use capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@comment.outer",
                    ["a,"] = "@parameter.inner",
                    ["i,"] = "@parameter.inner",
                    ["aa"] = "@statement.outer",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<M-l>"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<M-h>"] = "@parameter.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- Add jumps in the jumplist
                goto_next_start = {
                    ["]]"] = "@function.outer",
                },
                goto_next_end = {
                    ["]["] = "@function.outer",
                },
                goto_previous_start = {
                    ["[["] = "@function.outer",
                },
                goto_previous_end = {
                    ["[]"] = "@function.outer",
                },
            },
        },
    }

    local wk = require("which-key")
    wk.register({
        ["<M-l>"] = "Swap parameter with next",
        ["<M-h>"] = "Swap parameter with previous",

        ["]]"] = "Next function start",
        ["]["] = "Next function end",
        ["[["] = "Previous function start",
        ["[]"] = "Previous function end",
    })

    wk.register({
        ["af"] = "a function",
        ["if"] = "inner function",
        ["ac"] = "a comment",
        ["a,"] = "a parameter",
        ["i,"] = "inner parameter",
        ["aa"] = "a statement",
    }, { mode = "x" })

    wk.register({
        ["af"] = "a function",
        ["if"] = "inner function",
        ["ac"] = "a comment",
        ["a,"] = "a parameter",
        ["i,"] = "inner parameter",
        ["aa"] = "a statement",
    }, { mode = "o" })

end

return M
