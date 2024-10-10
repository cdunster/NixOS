local M = {}

M.config = function()
    require("telescope").setup({
        defaults = {
            cache_picker = { num_pickers = 5 },
        },
        pickers = {
            find_files = {
                find_command = { "fd", "--type=f", "--hidden", "--exclude=.git" }
            },
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown()
            }
        }
    })
    require("telescope").load_extension("ui-select")

    require("which-key").add({
        { "<leader>f",        require('telescope.builtin').find_files,      desc = "Find a file in working dir" },
        { "<leader>/",        require('telescope.builtin').live_grep,       desc = "Search file content in working dir" },
        { "<leader>*",        require('telescope.builtin').grep_string,     desc = "Search current string in working dir" },
        { "<leader>b",        require('telescope.builtin').buffers,         desc = "List open buffers" },
        { "<leader>q",        require('telescope.builtin').quickfix,        desc = "List quick-fixes in telescope" },
        { "<leader>Q",        require('telescope.builtin').quickfixhistory, desc = "List quick-fix history in telescope" },
        { "<leader><leader>", require('telescope.builtin').pickers,         desc = "List previously open telescope pickers" },
    })
end

return M
