local M = {}

M.config = function()
    local wk = require("which-key")

    wk.register({
        ["<C-f>"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find a file in working dir" },
        ["<C-g>"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Search file content in working dir" },
    })
end

return M
