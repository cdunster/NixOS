-- Set the custom statusline.
vim.o.statusline = '[%n] %<%f%m %{v:lua.LspStatusLine()} %{ObsessionStatus()}%=%{FugitiveHead()}'

function _G.LspStatusLine()
    if vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0 })) then
        return ''
    end

    local err = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warn = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    return 'E' .. tostring(err) .. ' W' .. tostring(warn)
end
