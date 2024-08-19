-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local J = require("util.util")

local function get_buffer_dir()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  path = path and vim.fs.dirname(path) or vim.loop.cwd()
  return path
end

-- Start LazyVim defaults, copied from GitHub
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- -- better up/down
-- map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
--
-- Move to window using the <ctrl> hjkl keys
map("n", "<leader>wh", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<leader>wj", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<leader>wk", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<leader>wl", "<C-w>l", { desc = "Go to right window", remap = true })
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<leader>wH", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<leader>wJ", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<leader>wK", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<leader>wL", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- "Zoom" window, i.e. open it in a new tab
map("n", "<leader>wz", function() vim.cmd("tabnew | b#") end, { desc = "Zoom" })
map("n", "<leader>wZ", function() vim.cmd("tabnext 1 | tabonly") end, { desc = "Close extra tabs" })

-- -- Move Lines
-- map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
-- map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
-- map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
-- map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
--
-- -- buffers
-- if Util.has("bufferline.nvim") then
--   map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
--   map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
--   map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
--   map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
-- else
--   map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
--   map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
--   map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
--   map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- end

map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Alternate" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Only (close others)" })
-- map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- -- map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
-- --
-- -- -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- -- map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- -- map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- -- map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- -- map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- -- map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- -- map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- --
-- -- Add undo break-points
-- map("i", ",", ",<c-g>u")
-- map("i", ".", ".<c-g>u")
-- map("i", ";", ";<c-g>u")
--
-- save file
-- map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>ll", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

if not Util.has("trouble.nvim") then
  map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
  map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

map("n", "[Q", vim.cmd.colder, { desc = "Previous quickfix list" })
map("n", "]Q", vim.cmd.cnewer, { desc = "Next quickfix list" })

-- formatting
map({ "n", "v" }, "<leader>cf", function()
  Util.format({ force = true })
end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- toggle options
map("n", "<leader>uf", function() require("lazyvim.plugins.lsp.format").toggle(); end, { desc = "Toggle format on Save" })
map("n", "<leader>uS", function()
  Util.toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
  Util.toggle("wrap")
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function()
  Util.toggle("relativenumber", true)
  Util.toggle("number")
end, { desc = "Toggle Line Numbers" })
map("n", "<leader>uD", Util.toggle.diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
  Util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-- -- lazygit
-- map("n", "<leader>gg", function() Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
-- map("n", "<leader>gG", function() Util.float_term({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })
--
-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- -- floating terminal
local lazyterm = function()
  Util.float_term(nil, { cwd = Util.get_root() })
end
map("n", "<leader>fT", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<leader>ft", function()
  Util.float_term(nil, { cwd = get_buffer_dir() })
end, { desc = "Terminal (file dir)" })
-- map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
-- map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })
--
-- -- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
-- map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
-- map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
-- map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
-- map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
-- map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
--
-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
-- map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
-- map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
map("n", "<leader>tl", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader>tf", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader>t<tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader>t]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader>t[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- End LazyVim defaults, copied from GitHub

local keymap = vim.keymap.set

keymap({ "n", "x" }, "'", ":")
keymap("n", "<localleader>w", ":update<return>", { desc = "Save file" })

keymap({ "n", "x", "i" }, "<C-l>", ":GpWhisper<CR>", { desc = "Whisper" })

-- Default gd gD mappings from LazyVIm are here
-- ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/lsp/keymaps.lua:17
-- { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
-- { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
-- We disable them in LSP config, and reenable (with different keys) here
keymap("n", "<leader>v", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,
  { desc = "Go to definition" })
keymap("n", "<leader>V", vim.lsp.buf.declaration, { desc = "Go to declaration" })
-- keymap("n", "gD", "gd", { remap = false, desc = "Go to definition (orig)" })

-- Next/previous mapping prefixes, but easier to type
keymap("n", "<leader>N", "[", { remap = true })
keymap("n", "<leader>n", "]", { remap = true })

-- Copy/paste stuff
keymap({ "n", "x" }, "Y", '"+y', { desc = "Yank" })
keymap({ "n", "x" }, "<leader>yy", '"+y', { desc = "Yank" })
keymap({ "n", "x" }, "<leader>yd", '"+d', { desc = "Delete" })
keymap({ "n", "x" }, "<leader>yp", '"+p', { desc = "Paste" })
keymap({ "n", "x" }, "<leader>yP", '"+P', { desc = "Paste behind" })
keymap("n", "<leader>yf", ':let @+=expand("%")<CR>', { desc = "Copy filename (relative)" })
keymap("n", "<leader>yF", ':let @+=expand("%:p")<CR>', { desc = "Copy filename (absolute)" })

keymap({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
keymap({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
keymap({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
keymap({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
keymap("n", "]p", "<Plug>(YankyCycleForward)", { desc = "Next paste option" })
keymap("n", "[p", "<Plug>(YankyCycleBackward)", { desc = "Previous paste option" })

local wk = require("which-key")
wk.register({
  ["<leader>m"] = { name = "+grapple" },
  ["<leader>n"] = { name = "+next" },
  ["<leader>N"] = { name = "+Previous" },
  ["<leader>dl"] = { name = "+list" },
  ["<leader>df"] = { name = "+focus" },
  ["<leader>dw"] = { name = "+widgets" },
  ["<leader>o"] = { name = "+open" },
  ["<leader>z"] = { name = "+zet/wiki" },
  ["<leader>r"] = { name = "+run" },
  ["<leader>ug"] = { name = "+git" },
  ["<leader>uF"] = { name = "+fzf" },
  ["<leader>uL"] = { name = "+List" },
  ["<leader>gh"] = { name = "+hunk" },
  ["<leader>gt"] = { name = "+toggle" },
})

keymap("n", "<leader>wo", "<C-W>o", { desc = "Only window (close others)" })

keymap({ "n", "x" }, "<leader>fe", function()
  -- Would prefer `.toggle_float()`, so it's togglable, but it has a bug with
  -- setting alternate file that is too annoying atm
  require("oil").open()
end, { desc = "Explore (file dir)" })
keymap({ "n", "x" }, "<leader>fE", function()
  require("oil").open(require("lazyvim.util").get_root())
end, { desc = "Explore (root dir)" })

keymap("n", "<leader>gb", function() vim.cmd("Git blame") end, { desc = "Blame" })
keymap({ "n", "x" }, "<leader>gw", ":GBrowse<CR>", { desc = "Web browse" })
keymap({ "n", "x" }, "<leader>gW", ":GBrowse!<CR>", { desc = "Web link" })
keymap("n", "<leader>ge", function() vim.fn.feedkeys(":Gedit ") end, { desc = "Edit" })
keymap("n", "<leader>gE", function() vim.fn.feedkeys(":Gedit origin/master:%") end, { desc = "Edit origin/master" })
keymap("n", "<leader>gg", ":Git ", { desc = "Git" })

keymap("n", "<leader>gb", function()
  vim.cmd("Git blame")
end, { desc = "Blame" })
keymap("n", "<leader>gg", ":Git ", { desc = "Git" })

keymap("n", "<leader>rv", J.open_with_vscode, { desc = "VSCode" })

keymap("n", "<leader>ro", function()
  vim.cmd("ObsidianOpen")
end, { desc = "Obsidian" })

keymap("n", "<leader>rR", function()
  J.run_cmd({ "refresh-firefox" })
end, { desc = "Refresh (+focus)" })

keymap("n", "<leader>rtt", function()
  J.run_cmd({ "tmux", "send-keys", "-t", "logs", "C-l", "Up", "Enter" })
end, { desc = "Tmux re-run" })

-- lazygit
map("n", "<leader>gL", function() Util.float_term({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false }) end,
  { desc = "Lazygit (cwd)" })
map("n", "<leader>gl",
  function() Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false, ctrl_hjkl = false }) end,
  { desc = "Lazygit (root dir)" })

vim.api.nvim_create_user_command("LuaSnipEdit", function()
  require("luasnip.loaders").edit_snippet_files()
end, { nargs = "*" })

keymap({ "n", "x" }, "<leader>fs", function() vim.cmd("LuaSnipEdit") end, { desc = "Snippets" });

-- Capture tmux pane contents to temporary buffer
vim.api.nvim_create_user_command("TmuxCapturePane", function(opts)
  -- New buffer
  vim.cmd.new();
  -- Mark as temporary, so no warning on close
  vim.cmd.setlocal("buftype=nofile");
  -- Dump pane contents
  vim.cmd("read ! tmux capture-pane -p -S -100 -t '" .. (opts.args or "") .. "'");
  -- Remove blank lines at end of file
  vim.cmd("silent! keeppattern %s#\\($\\n\\s*\\)\\+\\%$##");
  -- Scroll to end
  vim.cmd.normal("G");
end, { nargs = 1 })

keymap("n", "<leader>rtr", function()
  vim.fn.feedkeys(":TmuxCapturePane logs:.");
end, { desc = "Tmux re-run" })

keymap("n", "<leader>ch", function()
  vim.lsp.buf.incoming_calls()
end, { desc = "call Hierarchy" })

keymap({ "n", "v" }, "<leader>us", function() vim.cmd("NoNeckPain") end, { desc = "No neck pain" })

keymap({ "n", "v" }, "<leader>ut", function() vim.cmd("TSContextToggle") end,
  { desc = "Toggle Treesitter context lines" })

keymap({ "n", "v" }, "<leader>x/", function()
  vim.cmd.vimgrep("//g %"); vim.cmd.copen();
end, { desc = "Search results to quickfix" })


keymap({ "n", "v" }, "<leader>dd", function()
  vim.cmd("DevdocsOpen")
end, { desc = "Search devdocs" })

keymap({ "n", "v" }, "U", function()
  vim.cmd("UndotreeToggle")
end, { desc = "Undotree" })

vim.api.nvim_create_user_command("Browse", function(opts)
  vim.cmd("!open '" .. vim.fn.escape(opts.args, "'\\#%") .. "'");
end, { nargs = 1 })

keymap({ "n", "x" }, "<leader>ld", ":Linediff<CR>", { desc = "Line diff" })
keymap({ "n", "x" }, "<leader>lD", ":LinediffReset<CR>", { desc = "Line diff reset" })
