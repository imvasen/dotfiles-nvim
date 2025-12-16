return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        always_show_by_pattern = { ".env*" },
        never_show = { "node_modules", ".git" },
      },
    },
    window = {
      position = "right",
    },
  },
}
