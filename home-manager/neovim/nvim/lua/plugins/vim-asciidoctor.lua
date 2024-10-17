local M = {}

M.config = function()
    vim.g.asciidoctor_fenced_languages = {
        "rust",
        "c",
        "python",
    }
end

return M
