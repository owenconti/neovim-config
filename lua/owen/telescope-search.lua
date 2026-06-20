local M = {}

local explicit_exclude_dirs = {
  'node_modules',
  'vendor',
  '.git',
  'public',
  'storage',
  'phpstan-tmp',
}

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

function M.rg_find_command()
  local command = {
    'rg',
    '--files',
    '--hidden',
    '--no-ignore',
  }

  vim.list_extend(command, M.rg_exclude_globs())

  return command
end

return M
