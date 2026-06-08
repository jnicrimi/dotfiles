local keymap = vim.keymap

-- Navigation
keymap.set("n", "<Down>", "gj")
keymap.set("n", "<Up>", "gk")

-- Search
keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { silent = true })

-- Line movement
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Buffer operations
keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader><Tab>", "<cmd>b#<CR>", { desc = "Last buffer" })
keymap.set("n", "<leader>bn", "<cmd>enew<CR>", { desc = "New buffer" })
keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" })
