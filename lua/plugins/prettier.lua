return {
  { "jose-elias-alvarez/null-ls.nvim" },
  {
    "MunifTanjim/prettier.nvim",
    config = function()
      local prettier = require("prettier")
      local wk = require("which-key")
      prettier.setup()
      vim.keymap.set("n", "<leader><F3>", "<cmd>Prettier<CR>")
      wk.add({
        { "<leader><F3>", desc = "Prettier buf", icon = " " },
      })
    end,
  },
}
