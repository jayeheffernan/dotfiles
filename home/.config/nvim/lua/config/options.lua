-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.clipboard = ""
vim.opt.wrap = true
vim.opt.timeoutlen = 100
vim.opt.relativenumber = false
vim.opt.conceallevel = 2

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.nvim_tree_disable_netrw = 0

vim.g.autoformat = true

vim.g.gutentags_ctags_executable = "~/.builds/bin/ctags"
