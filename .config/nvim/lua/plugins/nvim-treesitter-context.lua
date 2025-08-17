return {
  "nvim-treesitter/nvim-treesitter-context",
  main = "treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    enable = true,
    max_lines = 3,
  },
}
