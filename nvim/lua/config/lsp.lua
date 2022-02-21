local on_attach = function(client, bufnr)
    local wk = require("which-key")

    --Use K to show documentation in preview window.
    wk.register({
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Peek token documentation" },
    })

    --Navigate errors.
    wk.register({
        ["[e"] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Previous error" },
        ["]e"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next error" },
    })

    --Code navigation. With g prefix.
    wk.register({
        ["d"] = { "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", "Go to definition" },
        ["y"] = { "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>", "Go to type definition" },
        ["i"] = { "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", "Go to implementation" },
        ["r"] = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "List references" },
    }, { prefix = "g" })

    --Code action bindings with <leader>+c.
    wk.register({
        name = "+code",
        ["r"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename token" },
        ["a"] = { "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", "List code actions" },
        ["e"] = { "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>", "List errors" },
        ["o"] = { "<cmd>lua require('telescope.builtin').treesitter()<CR>", "List code outline" },
        ["s"] = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "List code symbols" },
        ["w"] = {
            name = "+workspace",
            ["e"] = { "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>", "List workspace errors" },
            ["s"] = { "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", "List workspace code symbols" },
        },
    }, { prefix = "<leader>c" })
end

local M = {}

M.config = function()
    local lsp = require("lspconfig")

    -- clangd LSP config for C/C++.
    lsp.clangd.setup({
        on_attach = on_attach,
    })

    -- rust_analyzer LSP config for Rust.
    lsp.rust_analyzer.setup({
        on_attach = on_attach,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            },
        },
    })
end

return M