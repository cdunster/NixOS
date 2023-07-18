local M = {}

M.config = function()
    vim.g.wiki_root = "~/wiki"
    vim.g.wiki_filetypes = { "adoc" }
    vim.g.wiki_link_extension = ".adoc"
    vim.g.wiki_link_target_type = "adoc_xref_bracket";
    vim.g.wiki_map_create_page = function(title) return title:lower():gsub("%s+", "_") end
    vim.g.wiki_map_text_to_link = function(title) return { title:lower():gsub("%s+", "_"), title } end
    vim.g.wiki_templates = {
        {
            match_func = function(context)
                return context.path_wiki:find("journal") ~= nil
            end,
            source_filename = "~/wiki/templates/journal.adoc"
        },
        {
            match_func = function(context)
                return context.path:find("wiki") ~= nil
            end,
            source_filename = "~/wiki/templates/page.adoc"
        },
    }

    require("which-key").register({
        name = "wiki",
        ["w"] = "Open the wiki index page",
        ["n"] = "Open (or create) a wiki page",
        ["x"] = "Reload the wiki.vim plugin",
        ["<leader>"] = {
            name = "journal",
            ["w"] = "Open (or create) current entry",
        }
    }, { prefix = "<leader>w" })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "asciidoc",
        callback = function()
            local buf = vim.api.nvim_get_current_buf()
            local wk = require("which-key")

            wk.register({
                ["f"] = "Toggle link/text",
                ["d"] = "Delete this page",
                ["r"] = "Rename this page",
                ["t"] = "Create/Update table of contents",
                ["T"] = "Create/Update local table of contents",
                ["p"] = "Export this page",
                ["g"] = {
                    name = "graph",
                    ["b"] = "Find backlinks to this page",
                    ["r"] = "Shows link relations",
                    ["c"] = "Check this page for broken links",
                    ["C"] = "Check the wiki for broken links",
                    ["i"] = "Show link graph in to this page",
                    ["o"] = "Show link graph out of this page",
                },
                ["l"] = {
                    name = "link",
                    ["l"] = "Show info on link",
                    ["h"] = "Set link title to target's header",
                },
                ["s"] = {
                    name = "tags",
                    ["l"] = "List all tags and their pages",
                    ["r"] = "Source wiki files and reload tags",
                    ["s"] = "List wiki pages that contain a tag",
                    ["n"] = "Rename a tag",
                },
            }, { prefix = "<leader>w", buffer = buf })

            wk.register({
                name = "wiki",
                ["p"] = "Export selection",
            }, { prefix = "<leader>w", mode = "x", buffer = buf })

            wk.register({
                ["<tab>"] = "Go to next link",
                ["<cr>"] = "Follow link",
                ["<c-w><cr>"] = "Follow link in horizontal split",
                ["<c-w><tab>"] = "Follow link in vertical split",
                ["<c-w>u"] = "Follow link in a tab",
                ["<s-tab>"] = "Go to previous link",
                ["<bs>"] = "Go back to previous page",
                ["gl"] = "Toggle link/text",
            }, { buffer = buf })

            wk.register({
                ["<cr>"] = "Toggle link/text",
                ["au"] = "a link's URL",
                ["iu"] = "inner link's URL",
                ["at"] = "a link's text",
                ["it"] = "inner link's text",
            }, { mode = "x", buffer = buf })

            wk.register({
                ["au"] = "a link's URL",
                ["iu"] = "inner link's URL",
                ["at"] = "a link's text",
                ["it"] = "inner link's text",
            }, { mode = "o", buffer = buf })
        end,
    })
end

return M
