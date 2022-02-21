--Set the custom statusline.
vim.o.statusline = "[%n] %<%f%m %{v:lua.LspStatus()}%=%{FugitiveHead()}"

function _G.LspStatus()
    if vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
        return ""
    end

    local err = vim.lsp.diagnostic.get_count(0, [[Error]])
    local warn = vim.lsp.diagnostic.get_count(0, [[Warning]])
    return "E"..tostring(err).." W"..tostring(warn)
end
