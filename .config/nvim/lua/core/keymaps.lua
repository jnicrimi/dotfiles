local keymap = vim.keymap

-- Navigation
keymap.set('n', '<Down>', 'gj')
keymap.set('n', '<Up>', 'gk')

-- Search
keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', { silent = true })

-- Buffer operations
keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Delete buffer' })
keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous buffer' })
