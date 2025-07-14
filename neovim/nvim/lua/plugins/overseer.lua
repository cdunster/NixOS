local M = {}

M.config = function()
    local overseer = require('overseer')

    overseer.setup()
    overseer.load_template("nix")

    require('which-key').add({
        { '<leader>o',  group = '+overseer' },
        { '<leader>or', require('overseer').run_template, desc = 'Show list of runnable tasks' },
        { '<leader>oo', require('overseer').open,         desc = 'Open list of running or ran tasks' },
    })
end

return M
