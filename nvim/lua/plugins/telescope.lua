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
    require("telescope").load_extension("cmdline")

    require("which-key").add({
        { "<leader>f",        require('telescope.builtin').find_files,         desc = "Find a file in working dir" },
        { "<leader>/",        require('telescope.builtin').live_grep,          desc = "Search file content in working dir" },
        { "<leader>*",        require('telescope.builtin').grep_string,        desc = "Search current string in working dir" },
        { "<leader>b",        require('telescope.builtin').buffers,            desc = "List open buffers" },
        { "<leader><leader>", require('telescope.builtin').resume,             desc = "Resume last telescope picker" },

        { ":",                require('telescope').extensions.cmdline.cmdline, desc = "Open the cmdline in a telescope window" },
    })
end

return M
