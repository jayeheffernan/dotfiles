-- Large-file options
vim.g.syntax = false
vim.g.filetype = false
vim.opt.undofile = false
vim.opt.swapfile = false
vim.opt.loadplugins = false

-- Other options
vim.opt.compatible = false
vim.opt.number = true
vim.opt.modeline = false

-- Mappings
local keymap = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = ","

keymap({ "n", "x" }, "'", ":")
keymap("n", "<localleader>w", ":update<return>", { desc = "Save file" })
