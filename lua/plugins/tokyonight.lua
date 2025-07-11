return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, colors)
        hl.ColorColumn = { bg = colors.bg_highlight }
        hl.WinSeparator = { bg = colors.bg_dark }
      end,
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      fzf_colors = {
        true,
        bg = "-1",
        gutter = "-1",
      },
    },
  },
}
