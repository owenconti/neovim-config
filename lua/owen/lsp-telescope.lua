local api = vim.api
local lsp = vim.lsp

local conf = require('telescope.config').values
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local pickers = require('telescope.pickers')
local utils = require('telescope.utils')

local M = {}

local function client_position_params(win, extra)
  win = win or api.nvim_get_current_win()
  return function(client)
    local params = lsp.util.make_position_params(win, client.offset_encoding)
    if extra then
      params = vim.tbl_extend('force', params, extra)
    end
    return params
  end
end

local function is_vendor_path(filename)
  return filename and (filename:find('/vendor/', 1, true) ~= nil or filename:sub(1, 7) == 'vendor/')
end

local function real_location_key(item)
  local realpath = vim.uv.fs_realpath(item.filename) or item.filename
  return table.concat({
    realpath or '',
    item.lnum or '',
    item.col or '',
  }, ':')
end

local function filter_vendor_duplicates(items)
  local has_source_location = {}

  for _, item in ipairs(items) do
    if not is_vendor_path(item.filename) then
      has_source_location[real_location_key(item)] = true
    end
  end

  return vim.tbl_filter(function(item)
    return not (is_vendor_path(item.filename) and has_source_location[real_location_key(item)])
  end, items)
end

local function filter_current_reference(action, items, opts)
  if action ~= 'textDocument/references' or opts.include_current_line then
    return items
  end

  local lnum = api.nvim_win_get_cursor(opts.winnr)[1]
  return vim.tbl_filter(function(item)
    return not (item.filename == opts.curr_filepath and item.lnum == lnum)
  end, items)
end

local function filter_file_ignore_patterns(items, opts)
  local file_ignore_patterns = opts.file_ignore_patterns or conf.file_ignore_patterns or {}
  if vim.tbl_isempty(file_ignore_patterns) then
    return items
  end

  return vim.tbl_filter(function(item)
    for _, pattern in ipairs(file_ignore_patterns) do
      if item.filename and item.filename:match(pattern) then
        return false
      end
    end
    return true
  end, items)
end

local function list_or_jump(action, title, funname, params, opts)
  opts = opts or {}
  opts.bufnr = opts.bufnr or api.nvim_get_current_buf()
  opts.winnr = opts.winnr or api.nvim_get_current_win()
  opts.reuse_win = opts.reuse_win or false
  opts.curr_filepath = api.nvim_buf_get_name(opts.bufnr)

  lsp.buf_request_all(opts.bufnr, action, params, function(results_per_client)
    local items = {}
    local first_encoding
    local errors = {}

    for client_id, result_or_error in pairs(results_per_client) do
      local error, result = result_or_error.err, result_or_error.result
      if error then
        errors[client_id] = error
      elseif result ~= nil then
        local locations = {}
        if vim.islist(result) then
          vim.list_extend(locations, result)
        else
          table.insert(locations, result)
        end

        local client = lsp.get_client_by_id(client_id)
        local offset_encoding = client and client.offset_encoding or 'utf-16'
        if not vim.tbl_isempty(locations) then
          first_encoding = first_encoding or offset_encoding
        end

        vim.list_extend(items, lsp.util.locations_to_items(locations, offset_encoding))
      end
    end

    for _, error in pairs(errors) do
      utils.notify(funname, { msg = action .. ' : ' .. error.message, level = 'ERROR' })
    end

    items = filter_file_ignore_patterns(items, opts)
    items = filter_vendor_duplicates(items)
    items = filter_current_reference(action, items, opts)

    if vim.tbl_isempty(items) then
      utils.notify(funname, {
        msg = string.format('No %s found', title),
        level = 'INFO',
      })
      return
    end

    if #items == 1 and opts.jump_type ~= 'never' then
      lsp.util.show_document(items[1].user_data, first_encoding, { reuse_win = opts.reuse_win })
      return
    end

    pickers
      .new(opts, {
        prompt_title = title,
        finder = finders.new_table({
          results = items,
          entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
        }),
        previewer = conf.qflist_previewer(opts),
        sorter = conf.generic_sorter(opts),
        push_cursor_on_edit = true,
        push_tagstack_on_edit = true,
      })
      :find()
  end)
end

function M.references(opts)
  opts = opts or {}
  opts.include_current_line = opts.include_current_line or false

  return list_or_jump(
    'textDocument/references',
    'LSP References',
    'lsp_telescope.references',
    client_position_params(opts.winnr, {
      context = { includeDeclaration = opts.include_declaration ~= false },
    }),
    opts
  )
end

function M.definitions(opts)
  opts = opts or {}
  return list_or_jump(
    'textDocument/definition',
    'LSP Definitions',
    'lsp_telescope.definitions',
    client_position_params(opts.winnr),
    opts
  )
end

function M.implementations(opts)
  opts = opts or {}
  return list_or_jump(
    'textDocument/implementation',
    'LSP Implementations',
    'lsp_telescope.implementations',
    client_position_params(opts.winnr),
    opts
  )
end

return M
