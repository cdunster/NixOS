local M = {}

M.config = function()
    require("which-key").add({
        { "<leader>n",  group = "+neorg" },
        { "<leader>nn", "<Plug>(neorg.dirman.new-note)",            desc = "New note" },
        { "<leader>nw", "<Plug>(neorg.telescope.switch_workspace)", desc = "Switch workspace" },
        { "<leader>nr", "<cmd>Neorg return<CR>",                    desc = "Close all Neorg files" },
    })

    require("neorg").setup({
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {},
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/repos/notes",
                        holo = "~/repos/notes/holo",
                    },
                    default_workspace = "notes",
                },
            },
            ["core.integrations.telescope"] = {},
        },
    })
end

return M