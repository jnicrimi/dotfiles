return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    delay = 100,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp" },
    },
    min_count_to_highlight = 2,
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
  keys = {
    {
      "]]",
      function()
        require("illuminate").goto_next_reference()
      end,
      desc = "次の参照へ移動",
    },
    {
      "[[",
      function()
        require("illuminate").goto_prev_reference()
      end,
      desc = "前の参照へ移動",
    },
  },
}
