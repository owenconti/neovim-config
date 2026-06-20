-- Mirror Diagonal `.vscode/settings.json` (achilleshr.runonsave): on PHP save, run
-- `.vscode/run-on-save <relativeFile>` from the repo root (docker rector + pint inside that script).

local vim = vim

local group = vim.api.nvim_create_augroup('owen-php-run-on-save', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
  group = group,
  pattern = { '*.php' },
  callback = function(args)
    local path = args.file
    if not path or path == '' then
      return
    end
    local root = vim.fs.normalize(vim.fs.root(path, { '.git' }) or '')
    if root == '' then
      return
    end
    local npath = vim.fs.normalize(path)
    local sep = npath:sub(#root + 1, #root + 1)
    if sep ~= '/' then
      return
    end
    local rel = npath:sub(#root + 2)
    if rel == '' then
      return
    end
    local script = vim.fs.joinpath(root, '.vscode', 'run-on-save')
    if vim.fn.filereadable(script) ~= 1 then
      return
    end
    vim.system({ 'bash', script, rel }, { cwd = root, text = true }, function(out)
      if out.code ~= 0 then
        vim.schedule(function()
          vim.notify(
            ('run-on-save failed (%d): %s'):format(out.code, (out.stderr or '') .. (out.stdout or '')),
            vim.log.levels.WARN
          )
        end)
      end
    end)
  end,
})
