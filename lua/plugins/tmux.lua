return {
  {
    "aserowy/tmux.nvim",
    config = function()
      -- Navigate tmux, and nvim splits.
      -- Sync nvim buffer with tmux buffer.
      require("tmux").setup({
        copy_sync = {
          enable = true,
          sync_clipboard = false,
          sync_registers = true,
        },
        resize = {
          enable_default_keybindings = false,
        },
      })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
      { mode = "t", "<c-h>", "<C-w><cmd>TmuxNavigateLeft<cr>" },
      { mode = "t", "<c-j>", "<C-w><cmd>TmuxNavigateDown<cr>" },
      { mode = "t", "<c-k>", "<C-w><cmd>TmuxNavigateUp<cr>" },
      { mode = "t", "<c-l>", "<C-w><cmd>TmuxNavigateRight<cr>" },
      { mode = "t", "<c-\\>", "<C-w><cmd>TmuxNavigatePrevious<cr>" },
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
}
