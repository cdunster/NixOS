local M = {}

M.config = function()
    require('gitsigns').setup({
        current_line_blame = true,
    })

    require('which-key').add({
        { ']g', require('gitsigns.actions').next_hunk, desc = 'Next git hunk' },
        { '[g', require('gitsigns.actions').prev_hunk, desc = 'Previous git hunk' },

        {
            { '<leader>g',  group = '+git' },
            { '<leader>gs', require('gitsigns').stage_hunk,      desc = 'Stage current hunk' },
            { '<leader>gS', require('gitsigns').stage_buffer,    desc = 'Stage current buffer' },
            { '<leader>gu', require('gitsigns').undo_stage_hunk, desc = 'Undo staging last hunk' },
            { '<leader>gr', require('gitsigns').reset_hunk,      desc = 'Reset current hunk' },
            { '<leader>gR', require('gitsigns').reset_buffer,    desc = 'Reset current buffer' },
            { '<leader>gp', require('gitsigns').preview_hunk,    desc = 'Preview current hunk' },
        },

        {
            mode = 'o',
            { 'ih', require('gitsigns.actions').select_hunk, desc = 'Select git hunk' },
        },

        {
            mode = 'x',
            { 'ih', require('gitsigns.actions').select_hunk, desc = 'Select git hunk' },
        },


        {
            mode = 'v',
            { '<leader>g',  group = '+git' },
            { '<leader>gs', function() require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, desc = 'Stage selected hunk(s)' },
            { '<leader>gr', function() require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, desc = 'Reset selected hunk(s)' },
        },
    })
end

return M
