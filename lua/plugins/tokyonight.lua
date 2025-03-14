return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",
    transparent = true,
    on_highlights = function(hl, _)
      hl.ColorColumn = { bg = "#444444" }
      hl.WinSeparator = { bg = "#000000" }
    end,
  },
}
