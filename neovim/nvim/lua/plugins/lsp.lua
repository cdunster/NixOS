local on_attach_extra = function()
    -- Enable LSP signature plugin.
    require("lsp_signature").on_attach()

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
end

local M = {}

M.config = function()
    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- The default configuration for all enabled LSPs
    vim.lsp.config('*', {
        capabilities = capabilities,
    })

    -- clangd LSP config for C/C++.
    vim.lsp.enable('clangd')
    vim.lsp.config('clangd', {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    })

    -- Use rustaceanvim plugin for Rust.
    vim.g.rustaceanvim = {
        server = {
            capabilities = capabilities,
            default_settings = {
                ["rust-analyzer"] = {
                    diagnostics = {
                        enable = true,
                        disabled = { "unresolved-proc-macro" },
                    },
                },
            },
        },
    }

    -- Use flutter-tools.nvim for Flutter/Dart.
    require("flutter-tools").setup({
        lsp = {
            capabilities = capabilities,
        }
    })

    -- pyright LSP config for Python.
    vim.lsp.enable('pyright')

    -- Lua LS LSP config.
    vim.lsp.enable('lua_ls')
    vim.lsp.config('lua_ls', {
        on_init = function(client)
            if client.workspace_folders[1].name == "/etc/nixos" then
                client.config.settings.Lua.runtime.version = 'LuaJIT'
                client.config.settings.Lua.diagnostics.globals = { 'vim' }
                client.config.settings.Lua.workspace.library = vim.api.nvim_get_runtime_file("", true)
                client.config.settings.Lua.workspace.checkThirdParty = false
            end

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            return true
        end,
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

    vim.lsp.enable('cssls')
    vim.lsp.config('cssls', {
        capabilities = css_capabilities,
    })

    -- TypeScript and JavaScript
    vim.lsp.enable('ts_ls')

    -- Svelte (JS framework)
    vim.lsp.enable('svelte')

    -- nixd LSP config for Nix.
    vim.lsp.enable('nixd')
    vim.lsp.config('nixd', {
        settings = {
            nixd = {
                nixpkgs = {
                    expr = "import <nixpkgs> { }",
                },
                formatting = {
                    command = { "nixpkgs-fmt" },
                },
                options = {
                    nixos = {
                        expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
                    },
                    home_manager = {
                        expr =
                        '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ruixi@k-on".options',
                    },
                },
            },
        },
    })

    -- GDScript LSP config for the Godot game engine.
    vim.lsp.enable('gdscript')

    -- gopls official LSP for GoLang.
    vim.lsp.enable('gopls')

    -- Call the on_attach function common for all LSPs
    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = on_attach_extra,
    })

    --Try to format on save but ignore any errors.
    vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function(opts)
            pcall(vim.lsp.buf.format, { bufnr = opts.buf })
        end,
    })
end

return M
