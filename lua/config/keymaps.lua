-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local wk = require("which-key")

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
vim.keymap.set("n", "<leader>et", ":Neotree toggle<CR>", { desc = "Toggle file tree" })

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    vim.keymap.set("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "<leader><F12>", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    vim.keymap.set("n", "<leader>ld", "<cmd>lua vim.diagnostic.config({virtual_text=true})<cr>", opts)
    vim.keymap.set("n", "<leader>lh", "<cmd>lua vim.diagnostic.config({virtual_text=false})<cr>", opts)
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
  { "<leader>ee", desc = "Harpoon explore", icon = "󱡀 " },
  { "<leader>ea", desc = "Harpoon add", icon = "󱡀 " },
  { "<leader>et", desc = "Toggle file tree", icon = " " },
})
