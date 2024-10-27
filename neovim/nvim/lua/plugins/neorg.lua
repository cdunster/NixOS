local M = {}

M.config = function()
    -- Bind with keymap first to disable default binding.
    vim.keymap.set("n", "<leader>n", "<Plug>(neorg.dirman.new-note)", {})

    require("which-key").add({
        { "<leader>n",  group = "+neorg" },
        { "<leader>nn", "<Plug>(neorg.dirman.new-note)",            desc = "New note" },
        { "<leader>nw", "<Plug>(neorg.telescope.switch_workspace)", desc = "Switch workspace" },
        { "<leader>nr", "<cmd>Neorg return<CR>",                    desc = "Close all Neorg files" },
    })

    vim.api.nvim_create_autocmd("Filetype", {
        pattern = "norg",
        callback = function()
            require("which-key").add({
                { "<localleader>c", group = "+code block" },
                { "<localleader>i", group = "+insert" },
                { "<localleader>l", group = "+list" },
                {
                    { "<localleader>n",  group = "+notes" },
                    -- Re-bind new note for norg files only.
                    { "<localleader>nn", "<Plug>(neorg.dirman.new-note)", desc = "New note" },
                },
                { "<localleader>t", group = "+todo" },
            })
        end,
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
            ["core.esupports.metagen"] = {
                config = {
                    author = "Callum Dunster",
                    timezone = "implicit-local", -- The timezone is currently wrong so just remove it.
                },
            },
            ["core.summary"] = {},
            ["core.integrations.telescope"] = {},
        },
    })
end

return M
