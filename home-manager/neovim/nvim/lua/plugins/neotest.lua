local M = {}

M.config = function()
    require("coverage").setup({
        lang = {
            rust = {
                project_files_only = false,
            }
        }
    })

    require("neotest").setup({
        adapters = {
            require("neotest-rust")({
                args = {
                    "--remap-path-prefix",
                    "--lcov",
                    "--output-path=lcov.info",
                },
            })
        }
    })

    require("which-key").add({
        { "<leader>t",  group = "+test" },
        { "<leader>tr", require("neotest").run.run,                                    desc = "Run all tests" },
        { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run all tests in current file" },
        { "<leader>to", require("neotest").output.open,                                desc = "Open the output of the closest test" },
        { "<leader>ts", require("neotest").summary.toggle,                             desc = "Toggle the summary panel" },
        { "<leader>tc", function() require("coverage").load(true) end,                 desc = "Load the code coverage" },
    })
end

return M
