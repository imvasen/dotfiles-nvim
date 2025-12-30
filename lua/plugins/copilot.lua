return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false,
    opts = {
      model = "claude-sonnet-4.5",
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    enabled = false,
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 75,
        hide_during_completion = false,
        keymap = {
          accept = "<M-y>",
          next = "<M-n>",
          prev = "<M-p>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}
