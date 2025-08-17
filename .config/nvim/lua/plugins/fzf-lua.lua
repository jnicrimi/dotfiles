return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({})
    local map = vim.keymap.set
    map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
    map("n", "<leader>gf", "<cmd>FzfLua git_files<cr>", { desc = "Git files" })
    map("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", { desc = "Git status" })
  end,
}
