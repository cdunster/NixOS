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
        ["d"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
        ["y"] = { "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>", "Go to type definition" },
        ["i"] = { "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", "Go to implementation" },
        ["r"] = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "List references" },
    }, { prefix = "g" })

    --Code action bindings with <leader>+c.
    wk.register({
        name = "+code",
        ["r"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename token" },
        ["a"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "List line code actions" },
        ["d"] = { "<cmd>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>", "List buffer diagnostics" },
        ["o"] = { "<cmd>lua require('telescope.builtin').treesitter()<CR>", "Show buffer code outline" },
        ["s"] = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "List buffer code symbols" },
        ["w"] = {
            name = "+workspace",
            ["d"] = { "<cmd>lua require('telescope.builtin').diagnostics()<CR>", "List workspace diagnostics" },
            ["s"] = { "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", "List workspace code symbols" },
        },
    }, { prefix = "<leader>c" })

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
                    diagnostics = {
                        enable = true,
                        disabled = { "unresolved-proc-macro" },
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

    -- Lua LS LSP config.
    lsp.lua_ls.setup({
        on_init = function(client)
            if next(vim.fs.find("source/main.lua", { upward = true })) then
                client.config.settings.Lua.runtime.nonstandardSymbol = { "+=", "-=", "*=", "/=" }
                client.config.settings.Lua.runtime.special = { import = "require" }
                client.config.settings.Lua.diagnostics.globals = { 'playdate' }
                client.config.settings.Lua.workspace.library = { os.getenv("PLAYDATE_SDK_PATH") .. "/CoreLibs/" }
            elseif client.workspace_folders[1].name == "/home/callum/.config/home-manager/nvim/lua/" then
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
    lsp.cssls.setup({
        cmd = { "css-languageserver", "--stdio" },
        on_attach = on_attach,
        capabilities = capabilities,
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
