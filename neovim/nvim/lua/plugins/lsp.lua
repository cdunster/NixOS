local on_attach = function(client, bufnr)
    -- Enable LSP signature plugin.
    require("lsp_signature").on_attach()

    local wk = require("which-key")

    require("which-key").add({
        --Use K to show documentation in preview window.
        { "K", vim.lsp.buf.hover, desc = "Peek token documentation" },

        --Navigate diagnostics.
        {
            { "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous diagnostic" },
            { "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next diagnostic" },
        },

        --Code navigation. With g prefix.
        {
            { "gd", vim.lsp.buf.definition,                            desc = "Go to definition" },
            { "gy", require('telescope.builtin').lsp_type_definitions, desc = "Go to type definition" },
            { "gi", require('telescope.builtin').lsp_implementations,  desc = "Go to implementation" },
            { "gr", require('telescope.builtin').lsp_references,       desc = "List references" },
        },

        --Code action bindings with <leader>+c.
        {
            { "<leader>c",  group = "+code" },
            { "<leader>cr", vim.lsp.buf.rename,                                                     desc = "Rename token" },
            { "<leader>ca", vim.lsp.buf.code_action,                                                desc = "List line code actions" },
            { "<leader>cd", function() require('telescope.builtin').diagnostics({ bufnr = 0 }) end, desc = "List buffer diagnostics" },
            { "<leader>co", require('telescope.builtin').treesitter,                                desc = "Show buffer code outline" },
            { "<leader>cs", require('telescope.builtin').lsp_document_symbols,                      desc = "List buffer code symbols" },
            {
                { "<leader>cw",  group = "+workspace" },
                { "<leader>cwd", require('telescope.builtin').diagnostics,           desc = "List workspace diagnostics" },
                { "<leader>cws", require('telescope.builtin').lsp_workspace_symbols, desc = "List workspace code symbols" },
            },
        },
    })

    --Format on save if the LSP supports it.
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                })
            end,
        })
    end
end

local M = {}

M.config = function()
    local lsp = require("lspconfig")

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- clangd LSP config for C/C++.
    lsp.clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    })

    -- Use rustaceanvim plugin for Rust.
    vim.g.rustaceanvim = {
        server = {
            on_attach = on_attach,
            capabilities = capabilities,
            default_settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy"
                    },
                    diagnostics = {
                        enable = true,
                        disabled = { "unresolved-proc-macro" },
                    },
                },
            },
        },
    }

    -- pyright LSP config for Python.
    lsp.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    -- Lua LS LSP config.
    lsp.lua_ls.setup({
        on_init = function(client)
            if next(vim.fs.find("source/main.lua", { upward = true })) then
                client.config.settings.Lua.runtime.nonstandardSymbol = { "+=", "-=", "*=", "/=" }
                client.config.settings.Lua.runtime.special = { import = "require" }
                client.config.settings.Lua.diagnostics.globals = { 'playdate' }
                client.config.settings.Lua.workspace.library = { os.getenv("PLAYDATE_SDK_PATH") .. "/CoreLibs/" }
            elseif client.workspace_folders[1].name == "/home/callum/.config/home-manager/nvim/lua/"
                or client.workspace_folders[1].name == "/etc/nixos/neovim/nvim"
            then
                client.config.settings.Lua.runtime.version = 'LuaJIT'
                client.config.settings.Lua.diagnostics.globals = { 'vim' }
                client.config.settings.Lua.workspace.library = vim.api.nvim_get_runtime_file("", true)
                client.config.settings.Lua.workspace.checkThirdParty = false
            end

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            return true
        end,
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {},
                diagnostics = {},
                workspace = {},
                telemetry = {
                    enable = false,
                }
            },
        },
    })

    -- vscode-css-languageserver for CSS.
    local css_capabilities = capabilities
    css_capabilities.textDocument.completion.completionItem.snippetSupport = true

    lsp.cssls.setup({
        on_attach = on_attach,
        capabilities = css_capabilities,
    })

    -- nixd LSP config for Nix.
    lsp.nixd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    -- Protobuf LSP config.
    lsp.bufls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    -- GDScript LSP config for the Godot game engine.
    lsp.gdscript.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

return M
