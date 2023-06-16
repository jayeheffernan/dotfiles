return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "js-debug-adapter")
        end,
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
