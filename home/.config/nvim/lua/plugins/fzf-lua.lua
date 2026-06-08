return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      grep = {
        RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
      },
    })
    local map = vim.keymap.set
    map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find buffers" })
    map("n", "<leader>ff", "<cmd>FzfLua git_files<cr>", { desc = "Find files" })
    map("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Grep" })
    map("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Find recent" })
    map("n", "<leader>fs", "<cmd>FzfLua git_status<cr>", { desc = "Find status" })
    map("n", "<leader>fw", "<cmd>FzfLua grep_cword<cr>", { desc = "Grep word under cursor" })
  end,
}
