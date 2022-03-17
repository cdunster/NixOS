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
    local wk = require("which-key")

    wk.register({
        name = "+git",
        ["g"] = { "<cmd>Git<cr>", "Git status" },
        ["d"] = { "<cmd>Gdiffsplit<cr>", "Git diff all changes" },
        ["b"] = { "<cmd>Git blame<cr>", "Git blame file" },
        ["P"] = { "<cmd>Git push<cr>", "Git push" },
        ["f"] = {
            name = "+file",
            ["r"] = { "<cmd>lua require('config.fugitive').git_rename()<cr>", "Git rename file" },
            ["m"] = { "<cmd>lua require('config.fugitive').git_move()<cr>", "Git move file" },
            ["d"] = { "<cmd>GDelete<cr>", "Git delete file" },
        },
    }, { prefix = "<leader>g" })
end

return M
