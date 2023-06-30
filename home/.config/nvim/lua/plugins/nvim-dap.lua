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

    keys = function()
      return {
        {
          "<leader>dB",
          function()
            require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
          end,
          desc = "Breakpoint Condition",
        },
        {
          "<leader>db",
          function()
            require("dap").toggle_breakpoint()
          end,
          desc = "Toggle Breakpoint",
        },
        {
          "<leader>dc",
          function()
            require("dap").continue()
          end,
          desc = "Continue",
        },
        {
          "<leader>dC",
          function()
            require("dap").run_to_cursor()
          end,
          desc = "Run to Cursor",
        },
        {
          "<leader>di",
          function()
            require("dap").step_into()
          end,
          desc = "Step Into",
        },
        {
          "<leader>do",
          function()
            require("dap").step_out()
          end,
          desc = "Step Out",
        },
        {
          "<leader>dr",
          function()
            require("dap").repl.toggle()
          end,
          desc = "Toggle REPL",
        },
        {
          "<leader>ds",
          function()
            require("dap").session()
          end,
          desc = "Session",
        },
        {
          "<leader>dt",
          function()
            require("dap").terminate()
          end,
          desc = "Terminate",
        },
        {
          "<leader>dn",
          function()
            require("dap").step_over()
          end,
          desc = 'Step over ("next")',
        },
        {
          "<leader>dlb",
          function()
            require("dap").list_breakpoints()
            vim.cmd("copen")
          end,
          desc = "Breakpoints",
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
          desc = "Current frame",
        },
        {
          "<leader>dh",
          function()
            require("dap.ui.widgets").hover()
          end,
          desc = "Hover",
        },
        {
          "<leader>dp",
          function()
            require("dap.ui.widgets").preview()
          end,
          desc = "Preview",
        },
        {
          "<leader>dP",
          function()
            require("dap").pause()
          end,
          desc = "Pause",
        },
        {
          "<leader>dwp",
          function()
            require("dap.ui.widgets").preview()
          end,
          desc = "Preview",
        },
        {
          "<leader>dwh",
          function()
            require("dap.ui.widgets").hover()
          end,
          desc = "Hover",
        },
      }
    end,

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
}
