-- Activate the project's Python virtual environment when the working
-- directory lives inside one.
--
-- Ruff discovers virtual environments on its own, but basedpyright ignores
-- $VIRTUAL_ENV completely, so it is told the interpreter through the
-- python.pythonPath setting instead.
local venv_names = { "venv", ".venv", "env" }

local active --- @type string?
local injected_bin --- @type string?

local function path_parts()
  return vim.split(vim.env.PATH, ":", { plain = true })
end

local function find_venv(start)
  local dir = start
  while dir and dir ~= "/" do
    for _, name in ipairs(venv_names) do
      local path = ("%s/%s"):format(dir, name)
      if vim.fn.executable(path .. "/bin/python") == 1 then
        return path
      end
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if dir == vim.env.HOME or parent == dir then
      break
    end
    dir = parent
  end
end

local function set_python_path(path)
  vim.lsp.config("basedpyright", { settings = { python = { pythonPath = path } } })
  for _, client in ipairs(vim.lsp.get_clients({ name = "basedpyright" })) do
    client.settings = client.settings or {}
    client.settings.python = vim.tbl_deep_extend("force", client.settings.python or {}, { pythonPath = path })
    client:notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

-- Only ever add and remove our own entry, so anything else that changes PATH
-- during the session (Mason's bin directory, most importantly) is left alone.
local function activate(venv)
  local bin = venv .. "/bin"
  if not vim.tbl_contains(path_parts(), bin) then
    injected_bin = bin
    vim.env.PATH = bin .. ":" .. vim.env.PATH
  end

  vim.env.VIRTUAL_ENV = venv
  set_python_path(bin .. "/python")
  active = venv
  vim.notify("venv: " .. vim.fn.fnamemodify(venv, ":~"))
end

local function deactivate()
  if injected_bin then
    local parts = vim.tbl_filter(function(part)
      return part ~= injected_bin
    end, path_parts())
    vim.env.PATH = table.concat(parts, ":")
    injected_bin = nil
  end

  vim.env.VIRTUAL_ENV = nil
  set_python_path("")
  active = nil
end

local function update()
  local venv = find_venv(vim.fn.getcwd())
  if venv == active then
    return
  end

  deactivate()
  if venv then
    activate(venv)
  end
end

vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter" }, {
  group = vim.api.nvim_create_augroup("project_venv", { clear = true }),
  callback = vim.schedule_wrap(update),
  desc = "Activate the project Python virtual environment",
})
