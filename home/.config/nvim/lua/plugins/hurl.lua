return {
  {
    "jellydn/hurl.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "hurl",
    opts = {
      mode = "split",
      formatters = {
        json = { 'jq' },
        html = {
          'prettier', -- Make sure you have install prettier in your system, e.g: npm install -g prettier
          '--parser',
          'html',
        },
      },
    },
    keys = {
      -- Run API request
      { "<leader>rr", "<cmd>HurlRunner<CR>", desc = "Hurl all" },
      -- { "<leader>a",  "<cmd>HurlRunnerAt<CR>",      desc = "Run Api request" },
      -- { "<leader>te", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
      -- { "<leader>tm", "<cmd>HurlToggleMode<CR>",    desc = "Hurl Toggle Mode" },
      -- { "<leader>tv", "<cmd>HurlVerbose<CR>",       desc = "Run Api in verbose mode" },
      -- Run Hurl request in visual mode
      { "<leader>rr", ":HurlRunner<CR>",     desc = "Hurl",    mode = "v" },
    },
  }
}
