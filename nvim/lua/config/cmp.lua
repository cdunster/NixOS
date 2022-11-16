local M = {}

M.config = function()
    vim.o.completeopt = 'menu,menuone,noselect'

    local cmp = require("cmp")
    cmp.setup({
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        mapping = {
            ["<C-space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<Down>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<Up>'] = cmp.mapping.select_prev_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        },
        sources = {
            -- These are in order of priority. (Top source shown first).
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
            { name = "crates" },
            { name = "path" },
            { name = "buffer", keyword_length = 3 },
            { name = "spell", keyword_length = 3 },
        },
    })

    local wk = require("which-key")

    -- Jump between snippet placeholders in insert mode.
    wk.register({
        ["<Tab>"] = { "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'", "Select next snippet placeholder" },
        ["<S-Tab>"] = { "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'",
            "Select previous snippet placeholder" },
    }, { mode = "i", expr = true, noremap = false })

    -- Jump between snippet placeholders in select mode.
    wk.register({
        ["<Tab>"] = { "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'", "Select next snippet placeholder" },
        ["<S-Tab>"] = { "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'",
            "Select previous snippet placeholder" },
    }, { mode = "s", expr = true, noremap = false })
end

return M
