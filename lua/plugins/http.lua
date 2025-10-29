return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>rs", desc = "Send request" },
    { "<leader>ra", desc = "Send all requests" },
    { "<leader>rb", desc = "Open scratchpad" },
  },
  ft = { "http", "rest" },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>r",
    kulala_keymaps_prefix = "",
    ui = {
      split_direction = "horizontal",
      win_opts = {
        width = 50,
        height = 50,
      },
    },
  },
}
