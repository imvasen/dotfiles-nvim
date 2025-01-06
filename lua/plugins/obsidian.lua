return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    ui = { enable = false },
    workspaces = {
      {
        name = "Main",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Main Vault",
      },
    },
  },
}
