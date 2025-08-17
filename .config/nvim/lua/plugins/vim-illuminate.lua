return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    -- 遅延時間の設定（ミリ秒）
    delay = 100,
    -- 大きなファイルでの制限
    large_file_cutoff = 2000,
    -- 大きなファイルでの上書き設定
    large_file_overrides = {
      providers = { "lsp" },
    },
    -- 最小マッチ長
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
