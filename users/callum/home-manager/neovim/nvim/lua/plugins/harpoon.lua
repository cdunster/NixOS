local M = {}

M.config = function()
    require("telescope").load_extension("harpoon")

    require("which-key").add({
        { "<leader>j", require('telescope').extensions.harpoon.marks, desc = "View harpoon marks in project" },
        { "<leader>m", require("harpoon.mark").add_file,              desc = "Add a harpoon mark" },
        { "<C-j>",     require('harpoon.ui').nav_next,                desc = "Next harpoon mark" },
        { "<C-k>",     require('harpoon.ui').nav_prev,                desc = "Previous harpoon mark" },
    })
end

return M
