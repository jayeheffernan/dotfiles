-- This script directory
local sdir = vim.fn.expand("<sfile>:p:h") .. "/lua/plugins/"

return {
  {
    "junegunn/fzf",
    init = function()
      vim.cmd({ cmd = "source", args = { sdir .. "./fzf.init.vim" } })
      vim.g.fzf_layout = { window = { width = 0.7, height = 0.9 } }
    end,
    keys = function()
      local Util = require("lazyvim.util")

      local isFullscreen = false
      local toggleIsFullscreen = function()
        isFullscreen = not isFullscreen
      end
      -- fzf.vim commands use bang to activate as full-screen
      local getBang = function()
        if isFullscreen then
          return "!"
        end
        return ""
      end

      return {
        {
          "<leader>uF",
          desc = "FZF",
        },
        {
          "<leader>uFf",
          toggleIsFullscreen,
          desc = "Fullscreen",
        },
        {
          "<localleader>ss",
          function()
            vim.fn.feedkeys(":Rg" .. getBang() .. " ")
          end,
          desc = "Search (rg, cwd)",
        },
        {
          "<localleader>sS",
          function()
            vim.fn.feedkeys(":PRg" .. getBang() .. " ")
          end,
          desc = "Search (rg, dir)",
        },
        {
          "<localleader>sw",
          function()
            vim.fn.feedkeys(":Rg" .. getBang() .. " <C-r><C-w>")
          end,
          desc = "Word (cwd)",
        },
        {
          "<localleader>sW",
          function()
            vim.fn.feedkeys(":PRg" .. getBang() .. " <C-r><C-w>")
          end,
          desc = "Word word (root dir)",
        },
        -- -- find
        {
          "<localleader>fb",
          function()
            vim.cmd({ cmd = "Buffers", bang = isFullscreen })
          end,
          desc = "Buffers",
        },
        -- {
        --   "<C-p>",
        --   function()
        --     vim.cmd({ cmd = "Files", bang = isFullscreen })
        --   end,
        --   desc = "Find Files (cwd)",
        -- },
        {
          "<localleader>ff",
          function()
            vim.cmd({ cmd = "Files", bang = isFullscreen })
          end,
          desc = "Find Files (cwd)",
        },
        {
          "<localleader>fF",
          function()
            vim.cmd({ cmd = "Files", args = { Util.get_root() }, bang = isFullscreen })
          end,
          desc = "Find Files (root dir)",
        },
        {
          "<localleader>fr",
          function()
            vim.cmd({ cmd = "History", bang = isFullscreen })
          end,
          desc = "Recent",
        },
        -- { "<localleader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
        -- -- git
        {
          "<localleader>sgc",
          function()
            vim.cmd({ cmd = "Commits", bang = isFullscreen })
          end,
          desc = "commits",
        },
        {
          "<localleader>sgs",
          function()
            vim.cmd({ cmd = "GFiles?", bang = isFullscreen })
          end,
          desc = "status",
        },
        -- -- search
        -- { "<localleader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
        {
          "<localleader>sb",
          function()
            vim.cmd({ cmd = "BLines", bang = isFullscreen })
          end,
          desc = "Buffer",
        },
        {
          "<localleader>sc",
          function()
            vim.cmd({ cmd = "History:", bang = isFullscreen })
          end,
          desc = "Command History",
        },
        {
          "<localleader>sC",
          function()
            vim.cmd({ cmd = "Commands", bang = isFullscreen })
          end,
          desc = "Commands",
        },
        {
          "<localleader>sf",
          function()
            vim.cmd({ cmd = "RG", bang = isFullscreen })
          end,
          desc = "Find/Grep (cwd)",
        },
        {
          "<localleader>sF",
          function()
            vim.cmd({ cmd = "PRG", bang = isFullscreen })
          end,
          desc = "Find/Grep (root dir)",
        },

        -- Left-over mappings, not ported from LazyVim's Telescope equivalents
        -- { "<localleader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
        -- { "<localleader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
        -- { "<localleader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        -- { "<localleader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
        -- { "<localleader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        -- { "<localleader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        -- { "<localleader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
        -- { "<localleader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
        -- { "<localleader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
        -- {
        --   "<localleader>uC",
        --   Util.telescope("colorscheme", { enable_preview = true }),
        --   desc = "Colorscheme with preview",
        -- },
        -- {
        --   "<localleader>ss",
        --   Util.telescope("lsp_document_symbols", {
        --     symbols = {
        --       "Class",
        --       "Function",
        --       "Method",
        --       "Constructor",
        --       "Interface",
        --       "Module",
        --       "Struct",
        --       "Trait",
        --       "Field",
        --       "Property",
        --     },
        --   }),
        --   desc = "Goto Symbol",
        -- },
        -- {
        --   "<localleader>sS",
        --   Util.telescope("lsp_dynamic_workspace_symbols", {
        --     symbols = {
        --       "Class",
        --       "Function",
        --       "Method",
        --       "Constructor",
        --       "Interface",
        --       "Module",
        --       "Struct",
        --       "Trait",
        --       "Field",
        --       "Property",
        --     },
        --   }),
        --   desc = "Goto Symbol (Workspace)",
        -- },
      }
    end,
  },
  { "junegunn/fzf.vim" },
  { "gfanto/fzf-lsp.nvim" },
}
