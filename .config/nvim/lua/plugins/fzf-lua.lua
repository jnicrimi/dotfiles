return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({})
    local map = vim.keymap.set
    map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find buffers" })
    map("n", "<leader>ff", "<cmd>FzfLua git_files<cr>", { desc = "Find files" })
    map("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Find recent" })
    map("n", "<leader>fs", "<cmd>FzfLua git_status<cr>", { desc = "Find status" })
  end,
}
