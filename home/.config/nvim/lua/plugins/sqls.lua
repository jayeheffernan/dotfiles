return {
  "nanotee/sqls.nvim",
  enabled = false,
  -- module = { "sqls" },
  -- cmd = {
  --   "SqlsExecuteQuery",
  --   "SqlsExecuteQueryVertical",
  --   "SqlsShowDatabases",
  --   "SqlsShowSchemas",
  --   "SqlsShowConnections",
  --   "SqlsSwitchDatabase",
  --   "SqlsSwitchConnection",
  -- },
  -- init = function()
  --   print("jaye running init")
  --   require("lazyvim.util").on_attach(function(client, buffer)
  --     print("jaye got client", vim.inspect(client))
  --     if client.name ~= "sqls" then
  --       return
  --     end
  --     local sqls = require("sqls").on_attach(client, buffer)
  --     local function map(mode, l, r, desc)
  --       vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
  --     end
  --
  --     map("n", "<leader>ce", ":SqlsExecuteQuery<CR>", "Execute SQL")
  --   end)
  -- end,
  -- opts = {
  --   on_attach = function(client, buffer)
  --     print("jaye got client", vim.inspect(client))
  --     if client.name ~= "sqls" then
  --       return
  --     end
  --     local sqls = require("sqls").on_attach(client, bufnr)
  --     local function map(mode, l, r, desc)
  --       vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
  --     end
  --
  --     map("n", "<leader>ce", ":SqlsExecuteQuery<CR>", "Execute SQL")
  --   end,
  -- },
}