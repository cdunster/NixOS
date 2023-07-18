local M = {}

M.new_file = function()
    local title = vim.fn.input("Title: ")
    vim.cmd("redraw") -- Required to stop prints from appending text after input().
    if title == "" then
        return
    end
    local name = title:gsub(" ", "_") .. ".md"
    name = name:lower()
    local path = vim.fn.expand(vim.g.vimwiki_list[1].path) .. "/" .. name

    -- Check if file already exists.
    local file = io.open(path, "r")
    if file ~= nil then
        file:close()
        print("File " .. path .. " exists.")
        return
    end

    -- Create a new buffer, set the name to the file path, and set it to the current buffer.
    local buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_name(buf, path)
    vim.api.nvim_set_current_buf(buf)

    -- Add the content to the buffer (don't write to file).
    local content = {
        "---",
        "title: " .. title,
        "tags: []",
        "date: " .. os.date("%Y-%m-%d"),
        "---",
        "",
        "# " .. title,
    }
    vim.api.nvim_buf_set_lines(buf, 0, 0, true, content)
end

M.config = function()
    vim.g.vimwiki_list = {
        {
            path = '~/Dropbox/vimwiki',
            syntax = 'markdown',
            ext = '.md',
            links_space_char = '_'
        }
    }

    local wk = require("which-key")

    wk.register({
        name = "+vimwiki",
        ["w"] = "Open default wiki index file",
        ["t"] = "Open default wiki index file in new tab",
        ["s"] = "List available wiki index files",
        ["i"] = "Open default diary index file",
        ["c"] = { "<cmd>lua require('plugins.vimwiki').new_file()<CR>", "Create new wiki file" },
    }, { prefix = "<leader>w" })

    wk.register({
        name = "+diary",
        ["i"] = "Generate diary links",
        ["w"] = "Open today's entry",
        ["t"] = "Open today's entry in new tab",
        ["m"] = "Open tomorrow's entry",
        ["y"] = "Open yesterday's entry",
    }, { prefix = "<leader>w<leader>" })
end

return M
