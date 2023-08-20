--- Pads str to length len with char from right
str_lpad = function(str, len, char)
  return string.rep(char, len - #str) .. str
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "js-debug-adapter")
        end,
      },
    },

    keys = {
      {
        "<leader>dBc",
        function()
          local condition = vim.fn.input("Conditional breakpoint")
          if condition == ''
          then
            return
          end
          require("dap").set_breakpoint()
        end,
        desc = "Breakpoint Condition",
      },
      {
        "<leader>dn",
        function()
          require("dap").step_over()
        end,
        desc = 'Step over ("next")',
      },
      {
        "<leader>dBl",
        function()
          require("dap").list_breakpoints()
          vim.cmd("copen")
        end,
        desc = "list",
      },
      {
        "<leader>dD",
        function()
          require("dap").clear_breakpoints()
        end,
        desc = "Delete breakpoints",
      },
      {
        "<leader>dff",
        function()
          require("dap").focus_frame()
        end,
        desc = "current frame",
      },
      {
        "<leader>dBl",
        function()
          local log_message = vim.fn.input("Log message: ",
            "jayelp " .. str_lpad(tostring(vim.fn.line(".")), 4, "0") .. " ");
          if log_message == ''
          then
            return
          end
          require("dap").set_breakpoint("true", nil, log_message)
        end,
        desc = "Log-point",
      },
      {
        "<leader>dBL",
        function()
          local condition = vim.fn.input("Log condition: ", "true");
          if condition == ''
          then
            return
          end
          local log_message = vim.fn.input("Log message: ",
            "jayelp " .. str_lpad(tostring(vim.fn.line(".")), 4, "0") .. " ");
          if log_message == ''
          then
            return
          end
          require("dap").set_breakpoint(condition, nil, log_message);
        end,
        desc = "Conditional log-point",
      },
      {
        "<leader>dBB",
        function()
          vim.fn.feedkeys(':lua require("dap").set_breakpoint(--[[cond, hcond, logm]] "true", nil, nil)')
        end,
        desc = "set_breakpoint()",
      },
    },

    opts = function()
      local dap = require("dap")
      if not dap.adapters["pwa-node"] then
        dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = {
              require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end
      if not dap.adapters["node2"] then
        dap.adapters["vscode-node-2"] = {
          type = "executable",
          command = "node",
          args = { os.getenv("HOME") .. "/.builds/vscode-node-debug2/out/src/nodeDebug.js" },
        }
      end
      for _, language in ipairs({ "typescript", "javascript", "javascriptreact" }) do
        if not dap.configurations[language] then
          dap.configurations[language] = {}
        end
        local configs = {
          {
            type = "vscode-node-2",
            request = "attach",
            name = "Attach Ludwig server",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            port = 9229,
            smartStep = true,
            skipFiles = {
              "<node_internals>/**",
              "node_modules/**",
              "${workspaceFolder}/lib/cls/**",
              "${workspaceFolder}/backends/index.js",
              "${workspaceFolder}/backends/*/index.js",
              "${workspaceFolder}/backends/_integrations/*/index.js",
            },
            outFiles = { "${workspaceFolder}/dist/server/**/*.js" },
            sourceMapPathOverrides = {
              ["webpack://sleeping-duck/./*"] = "${workspaceFolder}/*",
              ["webpack://sleeping-duck/*"] = "*",
            },
          },
          {
            type = "vscode-node-2",
            request = "attach",
            name = "Attach Ludwig worker",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            port = 9228,
            smartStep = true,
            skipFiles = {
              "<node_internals>/**",
              "node_modules/**",
              "${workspaceFolder}/lib/cls/**",
              "${workspaceFolder}/backends/index.js",
              "${workspaceFolder}/backends/*/index.js",
              "${workspaceFolder}/backends/_integrations/*/index.js",
            },
            outFiles = { "${workspaceFolder}/dist/server/**/*.js" },
            sourceMapPathOverrides = {
              ["webpack://sleeping-duck/./*"] = "${workspaceFolder}/*",
              ["webpack://sleeping-duck/*"] = "*",
            },
          },

          {
            type = "vscode-node-2",
            request = "attach",
            name = "Attach Jest",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            port = 9227,
            smartStep = true,
            skipFiles = {
              "<node_internals>/**",
              "node_modules/**",
              "${workspaceFolder}/<node_internals>/**",
              "${workspaceFolder}/node_modules/**",
              "${workspaceFolder}/lib/cls/**",
              "${workspaceFolder}/backends/index.js",
              "${workspaceFolder}/backends/*/index.js",
              "${workspaceFolder}/backends/_integrations/*/index.js",
            },
            sourceMapPathOverrides = {
              ["./*"] = "${workspaceFolder}/*",
            },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
        local confExists = {}
        for _, existingConf in ipairs(dap.configurations[language]) do
          confExists[existingConf["name"]] = true
        end
        for _, conf in ipairs(configs) do
          if not confExists[conf["name"]] then
            table.insert(dap.configurations[language], conf)
          end
        end
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      controls = {
        element = "stacks",
        enabled = true,
        icons = {
          disconnect = "",
          pause = "",
          play = "",
          run_last = "",
          step_back = "",
          step_into = "",
          step_out = "",
          step_over = "",
          terminate = ""
        }
      },
      layouts = {
        {
          elements = { {
            id = "scopes",
            size = 0.45
          }, {
            id = "breakpoints",
            size = 0.15
          }, {
            id = "stacks",
            size = 0.30
          }, {
            id = "watches",
            size = 0.10
          } },
          position = "left",
          size = 50
        },
        -- {
        --   elements = { {
        --     id = "repl",
        --     size = 0.5
        --   }, {
        --     id = "console",
        --     size = 0.5
        --   } },
        --   position = "bottom",
        --   size = 10
        -- }
      },
    }
  },
}
