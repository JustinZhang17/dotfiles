return {
  name = 'opencode',
  dir = vim.fn.stdpath 'config' .. '/lua',
  lazy = false,
  config = function()
    local M = { bufnr = nil, winid = nil, root = nil }

    local function worktree_root()
      local file = vim.api.nvim_buf_get_name(0)
      local dir = file ~= '' and vim.fn.fnamemodify(file, ':p:h') or vim.fn.getcwd()
      local out = vim.fn.systemlist { 'git', '-C', dir, 'rev-parse', '--show-toplevel' }
      return vim.v.shell_error == 0 and out[1] or dir
    end

    local function open_float(bufnr)
      local width = math.floor(vim.o.columns * 0.75)
      local height = math.floor(vim.o.lines * 0.75)
      return vim.api.nvim_open_win(bufnr, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        style = 'minimal',
        border = 'single',
      })
    end

    local function hide()
      if M.winid and vim.api.nvim_win_is_valid(M.winid) then vim.api.nvim_win_close(M.winid, true) end
      M.winid = nil
    end

    local function show()
      M.winid = open_float(M.bufnr)
      vim.cmd 'startinsert'
    end

    local function stop()
      if M.bufnr and vim.api.nvim_buf_is_valid(M.bufnr) then vim.api.nvim_buf_delete(M.bufnr, { force = true }) end
      M.bufnr, M.root = nil, nil
    end

    local function spawn(root)
      local bufnr = vim.api.nvim_create_buf(false, true)
      local prev = vim.api.nvim_get_current_buf()
      vim.api.nvim_set_current_buf(bufnr)
      vim.fn.termopen('opencode', { cwd = root })
      vim.api.nvim_set_current_buf(prev)
      M.bufnr, M.root = bufnr, root

      vim.keymap.set('t', '<C-l>', hide, { buffer = bufnr, desc = 'Hide opencode' })

      vim.api.nvim_create_autocmd('TermClose', {
        buffer = bufnr,
        once = true,
        callback = function()
          if M.bufnr == bufnr then
            M.bufnr, M.root = nil, nil
          end
        end,
      })
    end

    local function toggle()
      if M.winid and vim.api.nvim_win_is_valid(M.winid) then
        hide()
        return
      end

      local root = worktree_root()

      if M.bufnr and vim.api.nvim_buf_is_valid(M.bufnr) and M.root ~= root then stop() end

      if not M.bufnr or not vim.api.nvim_buf_is_valid(M.bufnr) then spawn(root) end

      show()
    end

    vim.api.nvim_create_user_command('Opencode', toggle, {})
    vim.schedule(function() spawn(worktree_root()) end)
  end,
}
