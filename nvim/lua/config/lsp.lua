local on_attach = function(client, bufnr)
    -- Enable LSP signature plugin.
    require("lsp_signature").on_attach()

    local wk = require("which-key")

    --Use K to show documentation in preview window.
    wk.register({
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Peek token documentation" },
    })

    --Navigate diagnostics.
    wk.register({
        ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic" },
        ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
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
        ["a"] = { "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", "List code actions in buffer" },
        ["d"] = { "<cmd>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>", "List diagnostics in buffer" },
        ["o"] = { "<cmd>lua require('telescope.builtin').treesitter()<CR>", "List code outline of buffer" },
        ["s"] = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "List code symbols in buffer" },
        ["w"] = {
            name = "+workspace",
            ["d"] = { "<cmd>lua require('telescope.builtin').diagnostics()<CR>", "List diagnostics in workspace" },
            ["s"] = { "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", "List code symbols in workspace" },
        },
    }, { prefix = "<leader>c" })
end

local M = {}

M.config = function()
    local lsp = require("lspconfig")

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

    -- clangd LSP config for C/C++.
    lsp.clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    -- Use rust-tools plugin for Rust.
    require('rust-tools').setup({
        server = {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy"
                    },
                },
            },
        },
    })

    -- pyright LSP config for Python.
    lsp.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    -- sumneko LSP config for Lua.
    lsp.sumneko_lua.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

return M
