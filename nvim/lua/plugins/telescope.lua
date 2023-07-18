local M = {}

M.config = function()
    require("telescope").setup({
        pickers = {
            find_files = {
                find_command = { "fd", "--type=f", "--hidden", "--exclude=.git" }
            }
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown()
            }
        }
    })
    require("telescope").load_extension("ui-select")

    local wk = require("which-key")

    wk.register({
        ["f"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find a file in working dir" },
        ["/"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Search file content in working dir" },
        ["*"] = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "Search current string in working dir" },
        ["b"] = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "List open buffers" },
        ["<leader>"] = { "<cmd>lua require('telescope.builtin').resume()<cr>", "Resume last telescope picker" },
    }, { prefix = "<leader>" })
end

return M
