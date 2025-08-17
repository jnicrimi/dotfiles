local keymap = vim.keymap

keymap.set('n', '<Down>', 'gj')
keymap.set('n', '<Up>', 'gk')

keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', { silent = true })
