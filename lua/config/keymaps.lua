-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local wk = require("which-key")
local fzf = require("fzf-lua")

-- sudo write
vim.keymap.set("c", "w!!", "w !sudo tee >/dev/null %", { silent = true })
vim.keymap.set("n", "<leader>r", ":reg<CR>", { desc = "Show registers" })
vim.keymap.set("n", "<leader>bq", ":q<CR>", { silent = true })
vim.keymap.set("n", "<leader>bQ", ":q!<CR>", { silent = true })
vim.keymap.set("n", "<leader>bw", ":w<CR>", { silent = true, desc = "Write" })
vim.keymap.set("n", "<leader>bww", ":w<CR>", { silent = true, desc = "Write" })
vim.keymap.set("n", "<leader>bwq", ":wq<CR>", { silent = true, desc = "Write and quit" })
vim.keymap.set("n", "<leader>bW", ":w!!<CR>", { silent = true, desc = "Write as sudo" })

vim.keymap.del("n", "<leader>e")
vim.keymap.set("n", "<leader>em", fzf.marks, { desc = "Explore Marks" })
vim.keymap.set("n", "<leader>Dt", ":lua require('dbee').toggle()<CR>", { desc = "DBee" })

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = event.buf, desc = "Hover" })
    vim.keymap.set("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<cr>", { buffer = event.buf, desc = "Definition" })
    vim.keymap.set("n", "<leader><F12>", fzf.lsp_references, { desc = "Show References" })
    vim.keymap.set("n", "<leader>es", fzf.treesitter, { desc = "Treesitter" })
    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = event.buf, desc = "Rename" })
    vim.keymap.set(
      { "n", "x" },
      "<F3>",
      "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
      { buffer = event.buf, desc = "Format" }
    )
    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = event.buf, desc = "Code action" })
    vim.keymap.set(
      "n",
      "<leader>ld",
      "<cmd>lua vim.diagnostic.config({virtual_text=true})<cr>",
      { buffer = event.buf, desc = "Show diagnostics" }
    )
    vim.keymap.set(
      "n",
      "<leader>lh",
      "<cmd>lua vim.diagnostic.config({virtual_text=false})<cr>",
      { buffer = event.buf, desc = "Hide diagnostics" }
    )
  end,
})

wk.add({
  { "<leader>bq", desc = "Quit", icon = "󰈆 " },
  { "<leader>bQ", desc = "Quit without saving", icon = "󰈆 " },
  { "<leader>bw", desc = "Write", icon = "󰆓 " },
  { "<leader>bww", desc = "Write", icon = "󰆓 " },
  { "<leader>bwq", desc = "Write and quit", icon = "󰸧 " },
  { "<leader>bW", desc = "Write as sudo", icon = "󰽂 " },
  { "<leader>r", desc = "Show registers", icon = " " },
  { "<leader>e", group = "explore", icon = " " },
  { "<leader>eh", desc = "Harpoon explore", icon = "󱡀 " },
  { "<leader>ea", desc = "Harpoon add", icon = "󱡀 " },
})
