local M = {}

M.config = function()
    require("notify").setup({ top_down = false })
    vim.notify = require("notify")
end

return M
