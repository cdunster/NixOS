-- Show relative linenumbers when focused.
local numbertoggle = vim.api.nvim_create_augroup('numbertoggle', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
    pattern = '*',
    group = numbertoggle,
    callback = function() vim.opt.relativenumber = true end,
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
    pattern = '*',
    group = numbertoggle,
    callback = function() vim.opt.relativenumber = false end,
})

vim.opt.ignorecase = true               -- Enable case insensitive matching.
vim.opt.smartcase = true                -- Enable smart-case matching (match case insensitively unless upper-case used).
vim.opt.tabstop = 4                     -- Size of a tab.
vim.opt.softtabstop = 4                 -- See multiple spaces as a tab.
vim.opt.expandtab = true                -- Converts tabs to spaces.
vim.opt.shiftwidth = 4                  -- Auto-indented width.
vim.opt.number = true                   -- Enable line numbers.
vim.opt.relativenumber = true           -- Enable relative line numbers.
vim.opt.termguicolors = true            -- Enable full GUI colours in the terminal.
vim.opt.mouse = 'a'                     -- Enable the mouse for all modes.
vim.opt.clipboard:append('unnamedplus') -- Use the system clipboard.
vim.opt.scrolloff = 4                   -- Context lines around cursor when scrolling.
vim.opt.spell = false                   -- Disable built-in spell-checking (replaced by spelunker).
vim.opt.spelllang = 'en_gb'             -- Set language to proper English.
vim.opt.list = true                     -- Show whitespace characters.
vim.opt.lcs:append({ space = '·' })     -- Add spaces to the list of displayed whitespace characters.
vim.opt.hidden = true                   -- Keep buffers open in the background.
vim.opt.signcolumn = 'yes'              -- Always show the signcolumn.
vim.opt.hlsearch = false                -- Disable highlighting the search results.
vim.opt.wrap = false                    -- Don't wrap long lines onto multiple lines.
vim.opt.timeoutlen = 300                -- Set the time to wait for a mapped sequence to complete.
vim.opt.updatetime = 300                -- Better user experience.
vim.opt.wildmode = 'longest,list'       -- Enable bash-like tab completions.
vim.opt.conceallevel = 2                -- Set the level to conceal special characters such as markup format characters.
vim.opt.concealcursor = "n"             -- Also conceal special characters under cursor when in these modes.
vim.g.mapleader = ' '                   -- Set <SPC> to be the leader key for keybindings.
vim.g.maplocalleader = ','              -- Set ',' to be the local leader key for language specific keybindings.
