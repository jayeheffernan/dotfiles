local Job = require("plenary.job")

J = {}

function J.open_with_vscode()
  local git_root = vim.fn.fnameescape(vim.fn.trim(vim.fn.system("git rev-parse --show-toplevel")))
  local loc = vim.fn.join({ vim.fn.fnameescape(vim.fn.getreg("%")), ":", vim.fn.line("."), ":", vim.fn.col(".") }, "")
  local command = "code '" .. git_root .. "' --goto '" .. loc .. "'"
  vim.fn.system(command)
end

-- Taken from Harpoon's M.get_os_command_output()
function J.run_cmd(cmd, cwd)
  if type(cmd) ~= "table" then
    error("run_cmd() expect table arg")
  end
  local command = table.remove(cmd, 1)
  local stderr = {}
  local stdout, ret = Job:new({
    command = command,
    args = cmd,
    cwd = cwd or vim.loop.cwd(),
    on_stderr = function(_, data)
      table.insert(stderr, data)
    end,
  }):sync()
  return stdout, ret, stderr
end

return J
