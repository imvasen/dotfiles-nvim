return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope.nvim",
      opts = {
        defaults = {
          layout_config = {
            preview_width = 0.6,
          },
        },
      },
      lazy = true,
    },
  },
}
