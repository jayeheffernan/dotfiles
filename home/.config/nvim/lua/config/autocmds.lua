-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- TODO this doesn't seem to run
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    local msg = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    print(msg)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    local cmp = require("cmp")
    cmp.setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
    vim.keymap.set("n", "<leader>rf", function()
      vim.cmd("%DB")
    end, { desc = "Run SQL file" })
  end,
})
