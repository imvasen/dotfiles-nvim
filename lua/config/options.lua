-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "

local opt = vim.opt

opt.jumpoptions = "stack,view"
opt.listchars = { tab = "▸ ", trail = "·", nbsp = "␣" }
opt.clipboard = ""
opt.colorcolumn = "80,120"
opt.guicursor = "i:hor20-Cursor"
vim.g.snacks_animate = false
