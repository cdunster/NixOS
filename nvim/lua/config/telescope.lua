local M = {}

M.config = function()
    local wk = require("which-key")

    wk.register({
        ["<C-f>"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find a file" },
    })
end

return M
