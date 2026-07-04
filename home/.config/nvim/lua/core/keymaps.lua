local keymap = vim.keymap

-- Navigation
keymap.set("n", "<Down>", "gj", { desc = "Down (display line)" })
keymap.set("n", "<Up>", "gk", { desc = "Up (display line)" })

-- Search
keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Line movement
keymap.set("x", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move line down" })
keymap.set("x", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move line up" })

-- Buffer operations
keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader><Tab>", "<cmd>b#<CR>", { desc = "Last buffer" })
keymap.set("n", "<leader>bn", "<cmd>enew<CR>", { desc = "New buffer" })
keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })
