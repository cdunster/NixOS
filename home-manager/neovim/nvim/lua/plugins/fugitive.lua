local M = {}

M.git_move = function()
    local current_name = vim.api.nvim_buf_get_name(0)
    local new_name = vim.fn.input("Move to: ", current_name, "file")
    if new_name ~= "" then
        vim.cmd("GMove " .. new_name)
    end
end

M.git_rename = function()
    local new_name = vim.fn.input("New name: ", "", "file")
    if new_name ~= "" then
        vim.cmd("GRename " .. new_name)
    end
end

M.config = function()
    require("which-key").add({
        { "<leader>g",  group = "+git" },
        { "<leader>gg", "<cmd>Git<cr>",        desc = "Git status" },
        { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff all changes" },
        { "<leader>gb", "<cmd>Git blame<cr>",  desc = "Git blame file" },
        { "<leader>gP", "<cmd>Git push<cr>",   desc = "Git push" },

        {
            { "<leader>gf",  group = "+file" },
            { "<leader>gfr", require('plugins.fugitive').git_rename, desc = "Git rename file" },
            { "<leader>gfm", require('plugins.fugitive').git_move,   desc = "Git move file" },
            { "<leader>gfd", "<cmd>GDelete<cr>",                     desc = "Git delete file" },
        },
    })
end

return M
