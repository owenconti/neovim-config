local M = {}

local uv = vim.uv or vim.loop

local explicit_exclude_dirs = {
  'node_modules',
  'vendor',
  '.git',
  'public',
  'storage',
  'phpstan-tmp',
}

local function links_to_directory_outside(path, root)
  local target = uv.fs_realpath(path)

  if not target or target == root or vim.startswith(target, root .. '/') then
    return false
  end

  local stat = uv.fs_stat(target)

  return stat ~= nil and stat.type == 'directory'
end

-- find_files runs rg with -L, so a symlink pointing at a git worktree (or any
-- other tree outside the project) gets indexed as if it were project source.
function M.escaping_symlink_globs(cwd)
  local root = uv.fs_realpath(cwd or uv.cwd())
  local globs = {}

  if not root then
    return globs
  end

  local dir = uv.fs_scandir(root)

  if not dir then
    return globs
  end

  while true do
    local name, kind = uv.fs_scandir_next(dir)

    if not name then
      break
    end

    if kind == 'link' and links_to_directory_outside(root .. '/' .. name, root) then
      table.insert(globs, '--glob=!/' .. name)
    end
  end

  return globs
end

function M.rg_exclude_globs()
  local globs = {
    '--glob=!**/.DS_Store',
  }

  for _, dir in ipairs(explicit_exclude_dirs) do
    table.insert(globs, '--glob=!' .. dir .. '/**')
    table.insert(globs, '--glob=!**/' .. dir .. '/**')
  end

  return globs
end

function M.rg_find_command(opts)
  local command = {
    'rg',
    '--files',
    '--hidden',
    '--no-ignore',
  }

  vim.list_extend(command, M.rg_exclude_globs())
  vim.list_extend(command, M.escaping_symlink_globs(opts and opts.cwd))

  return command
end

function M.rg_find_files_command(opts)
  local command = {
    'rg',
    '--files',
    '--color',
    'never',
  }

  vim.list_extend(command, M.escaping_symlink_globs(opts and opts.cwd))

  return command
end

return M
