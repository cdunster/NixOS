local M = {}

M.config = function()
    require("zen-mode").setup({
        window = {
            width = 200,
        },
    })

    require("which-key").add({
        { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle zen mode" },
    })
end

return M
