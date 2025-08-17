return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  config = function()
    require("render-markdown").setup({
      heading = {
        backgrounds = {},
      },
    })
  end,
}
