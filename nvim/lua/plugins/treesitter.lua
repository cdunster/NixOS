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

    require("which-key").add({
        { "]]", desc = "Next function start" },
        { "][", desc = "Next function end" },
        { "[[", desc = "Previous function start" },
        { "[]", desc = "Previous function end" },

        {
            mode = "x",
            { "af", desc = "a function" },
            { "if", desc = "inner function" },
            { "ac", desc = "a comment" },
            { "a,", desc = "a parameter" },
            { "i,", desc = "inner parameter" },
            { "aa", desc = "a statement" },
        },

        {
            mode = "o",
            { "af", desc = "a function" },
            { "if", desc = "inner function" },
            { "ac", desc = "a comment" },
            { "a,", desc = "a parameter" },
            { "i,", desc = "inner parameter" },
            { "aa", desc = "a statement" },
        },
    })
end

return M
