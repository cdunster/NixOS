local M = {}

M.config = function()
    require("neotest").setup({
        adapters = {
            require("neotest-rust")({
                args = {
                    -- Needed to exclude this way because the plugin uses the `--workspace` option
                    "--exclude=rocsys-embedded-gpio-mini",
                },
            })
        }
    })

    require("which-key").register({
        name = "+test",
        ["r"] = { require("neotest").run.run, "Run all tests" },
        ["f"] = { function() require("neotest").run.run(vim.fn.expand("%")) end, "Run all tests in current file" },
        ["o"] = { require("neotest").output.open, "Open the output of the closest test" },
        ["s"] = { require("neotest").summary.toggle, "Toggle the summary panel" },
    }, { prefix = "<leader>t" })
end

return M
