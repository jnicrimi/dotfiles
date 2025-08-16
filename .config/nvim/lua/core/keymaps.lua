local keymap = vim.keymap

-- 折り返し行での移動
keymap.set('n', '<Down>', 'gj')
keymap.set('n', '<Up>', 'gk')

-- 検索ハイライト解除
keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', { silent = true })
