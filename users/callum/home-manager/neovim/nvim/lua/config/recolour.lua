local M = {}

function M.apply()
    vim.cmd.colorscheme('stylix')
end

-- Called remotely after a specialisation switch so drop the cached palette
-- module causing it to be re-read from disk.
function M.reload()
    package.loaded['stylix_palette'] = nil
    M.apply()
end

return M
