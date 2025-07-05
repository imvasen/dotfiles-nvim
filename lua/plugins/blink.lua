return {
  "Saghen/blink.cmp",
  opts = {
    completion = {
      menu = { auto_show = false },
      ghost_text = { enabled = false },
      accept = {
        auto_brackets = { enabled = false },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
      },
    },
    keymap = {
      preset = "default",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
