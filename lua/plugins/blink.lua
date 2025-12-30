return {
  "Saghen/blink.cmp",
  -- dependencies = { "fang2hou/blink-copilot" },
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
      default = {
        -- "copilot",
        "lsp",
        "path",
        "snippets",
        "buffer",
      },
      providers = {
        -- copilot = {
        --   name = "copilot",
        --   module = "blink-copilot",
        --   score_offset = 100,
        --   async = true,
        -- },
      },
    },
  },
}
