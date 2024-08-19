local J = require("util.util")

local imghack = false
local function go_to_md_link()
  local s, e = require("obsidian").util.cursor_on_markdown_link()
  if e then
    -- NB: are these return value names right? Not sure that's how pcall works
    local res, err = pcall(function()
      imghack = true
      return vim.cmd("ObsidianFollowLink")
    end)
    if err and err:match("note_id_func_found_image_link") then
      local link = vim.api.nvim_get_current_line():sub(s + 2, e - 2)
      local fname = "~/.vimwiki/notes/" .. link
      -- local cmd = "!wezterm cli split-pane --percent 80 -- bash -c 'wezterm imgcat --height 100\\% --width 100\\% "
      local cmd = "!wezterm cli split-pane -- bash -c 'wezterm imgcat "
          .. fname:gsub(" ", "\\ ")
          -- .. vim.fn.shellescape(fname)
          .. "; read"
          .. "'"
      print(cmd)
      vim.api.nvim_command(cmd)
    end
  else
    -- Follow normal http and file liks
    J.run_cmd({ "open", vim.fn.expand("<cfile>") })
  end
end

return {
  {
    "epwalsh/obsidian.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "junegunn/fzf",
      "folke/flash.nvim",
    },
    opts = {
      dir = "~/.vimwiki/notes", -- no need to call 'vim.fn.expand' here
        -- Where to put new notes created from completion. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "notes_subdir",
      completion = {
        -- If using nvim-cmp, otherwise set to false
        nvim_cmp = true,
        -- Trigger completion at 2 chars
        min_chars = 2,
      },
      mappings = {},

      -- Optional, customize how names/IDs for new notes are created.
      note_id_func = function(title)
        local ih = imghack
        imghack = false
        if title ~= nil then
          local img = ih and title:match("^a/")
          print(vim.inspect({ title = title, img = img, ih = ih }))
          if img then
            return error("note_id_func_found_image_link")
          end
          -- If title is given, transform it into valid file name.
          return title:gsub("[^A-Za-z0-9 _-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          local suffix = ""
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
          return tostring(os.time()) .. "-" .. suffix
        end
      end,

      disable_frontmatter = true,

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({ "open", url }) -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
      end,

      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = false,

      -- Optional, by default commands like `:ObsidianSearch` will attempt to use
      -- telescope.nvim, fzf-lua, and fzf.nvim (in that order), and use the
      -- first one they find. By setting this option to your preferred
      -- finder you can attempt it first. Note that if the specified finder
      -- is not installed, or if it the command does not support it, the
      -- remaining finders will be attempted in the original order.
      finder = "fzf.vim",
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      vim.keymap.set("n", "<leader>zi", function()
        vim.cmd("e ~/.vimwiki/notes/index.md")
      end, { desc = "Open index" })

      vim.keymap.set("n", "<leader>zn", ":ObsidianNew ", { desc = "New note" })

      -- Setup keymaps for markdown files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown" },
        callback = function()
          vim.keymap.set({ "n", "x" }, "<CR>", go_to_md_link)
          vim.keymap.set({ "n" }, "gs", function()
            require("flash").jump({
              pattern = "\\[\\[\\|https:",
              search = { mode = "search", },
              action = function(match, state)
                vim.api.nvim_win_call(match.win, function()
                  -- Move cursor to match location
                  vim.api.nvim_win_set_cursor(match.win, match.pos)
                  -- Go to link under cursor
                  go_to_md_link();
                end)
              end,
            })
          end
          )
          vim.keymap.set("n", "<leader>zv", function()
            vim.cmd("ObsidianOpen")
          end, { desc = "View with Obsidian" })
        end,
      })
    end,
  },
}
