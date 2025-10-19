-- Set the custom statusline.
vim.o.statusline = '[%n] %<%f%m %{v:lua.LspStatus()} %{ObsessionStatus()}%=%{FugitiveHead()}'

function _G.LspStatus()
    if vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
        return ''
    end

    local err = table.getn(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }))
    local warn = table.getn(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }))
    return 'E' .. tostring(err) .. ' W' .. tostring(warn)
end
