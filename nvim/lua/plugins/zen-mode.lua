local M = {}

M.config = function()
    require("zen-mode").setup({
        window = {
            width = 200,
        },
    })

    require("which-key").register({
        ["<leader>z"] = { "<cmd>ZenMode<cr>", "Toggle zen mode" },
    })
end

return M
