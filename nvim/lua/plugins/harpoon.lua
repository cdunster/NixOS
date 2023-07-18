local M = {}

M.config = function()
    require("telescope").load_extension("harpoon")

    local wk = require("which-key")

    wk.register({
        ["j"] = { require('telescope').extensions.harpoon.marks, "View harpoon marks in project" },
        ["m"] = { require("harpoon.mark").add_file, "Add a harpoon mark" },
    }, { prefix = "<leader>" })

    wk.register({
        ["<C-j>"] = { require('harpoon.ui').nav_next, "Next harpoon mark" },
        ["<C-k>"] = { require('harpoon.ui').nav_prev, "Previous harpoon mark" },
    })
end

return M
