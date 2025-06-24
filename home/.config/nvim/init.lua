require('config.lazy')

-- Mappings {{{1
-- =============

-- other convenient mappings {{{2
-- ------------------------------

-- move by displayed line
vim.keymap.set({ 'n', 'x' }, 't', 'gj')
vim.keymap.set({ 'n', 'x' }, 's', 'gk')

-- write the buffer more easily
vim.keymap.set('n', '<Leader><Leader>', ':w<CR>')

-- toggle the display of hidden characters (in 'listchars')
vim.keymap.set('n', '<Leader>cl', ':set list!<CR>', { silent = true })

-- cd to the directory of the current file
vim.keymap.set('n', '<Leader>cd', ':cd %:p:h<CR>', { silent = true })

-- '<Esc>' is far away, use '<C-Space>' instead
vim.keymap.set({ 'n', 'x', 'o', 'i' }, '<C-Space>', '<Esc>', { desc = "Escape synonym", remap = true })
vim.keymap.set('c', '<C-Space>', '<C-c>', { desc = "Leave command mode" })
vim.keymap.set('t', '<C-Space>', '<C-\\><C-n>', { desc = "Leave terminal mode" })

-- Use ' to go to the exact mark, since it is more accessible
vim.keymap.set({ 'n', 'x', 'o' }, "'", '`')
vim.keymap.set({ 'n', 'x', 'o' }, '`', "'")

-- Use 'C'/'R' to operate on the current line rather than the screen
-- we want 'C' to alternate between first non-blank character and start of line

local caret = function(mode)
  local inner = function()
    if mode == 'x' then
      vim.cmd [[normal! gv]]
    end
    local pos = vim.fn.col('.')
    vim.cmd [[normal! ^]]
    if pos == vim.fn.col('.') then
      vim.cmd [[normal! 0]]
    end
  end
  return inner
end

vim.keymap.set({ 'n', 'o' }, 'C', caret('n'), { silent = true })
vim.keymap.set('x', 'C', caret('x'), { silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'R', '$')

-- Use 'U' for redo, basic 'U' is useless
vim.keymap.set('n', 'U', '<C-r>')

-- '*' is far away, we use 'M' to put the word under the cursor in the search
-- register, then we can move with 'n'/'N'
vim.keymap.set({ 'n', 'x', 'o' }, 'M', [[<cmd>silent! execute "normal! *\<C-o>"<CR>]])

-- Directional arrows operate on windows
vim.keymap.set('n', '<left>', '<C-w>h')
vim.keymap.set('n', '<down>', '<C-w>j')
vim.keymap.set('n', '<up>', '<C-w>k')
vim.keymap.set('n', '<right>', '<C-w>l')
vim.keymap.set('n', '<S-left>', '<C-w>H')
vim.keymap.set('n', '<S-down>', '<C-w>J')
vim.keymap.set('n', '<S-up>', '<C-w>K')
vim.keymap.set('n', '<S-right>', '<C-w>L')

-- Jump open fold when jumping with '[count]G'
vim.keymap.set('n', 'G', function() if vim.v.count ~= 0 then return 'Gzv' else return 'G' end end, { expr = true })

-- Convenient to move to end of next fold and open it
vim.keymap.set('n', '<Leader>z', 'zjzxzjk')

-- Yank all buffer to system clipboard as HTML using pandoc
vim.keymap.set('n', '<Leader>y', [[:<C-u>silent! w ! pandoc -t html | wl-copy -t text/html<CR>]], { silent = true })


-- Style {{{1
-- ===========================
vim.o.title = true
vim.o.bg = 'light'

-- Various settings {{{1
-- =====================


-- search {{{2
-- -----------
vim.o.ignorecase = true
vim.o.smartcase = true

-- keep more context when scrolling {{{2
-- -------------------------------------
vim.o.scrolloff = 4
vim.o.sidescrolloff = 8

-- error displayed visually {{{2
-- -----------------------------
vim.o.visualbell = true

-- disable mouse in insert mode {{{2
-- ---------------------------------
--  the standard setting is responsible for mistakes when inadvertently
--  touching the touchpad
vim.o.mouse = 'nvc'

-- conceal characters, especially nice for TeX {{{2
-- ------------------------------------------------
vim.o.conceallevel = 2

-- use unicode characters for listchars, stolen from previous version of
-- sensible {{{2
-- ---------------------------------------------------------------------
vim.opt.listchars = {
  tab = '⇥ ',
  trail = '␣',
  extends = '⇉',
  precedes = '⇇',
  nbsp = '·',
}

-- command-line completion {{{2
-- ----------------------------
vim.opt.wildmode = { 'longest:full', 'full' }

-- persistent undo {{{2
-- --------------------
vim.o.undofile = true

-- changing buffers {{{2
-- ---------------------
vim.o.confirm = true
vim.o.hidden = false

-- generate ctags on each write {{{2
-- ---------------------------------
local augroup = vim.api.nvim_create_augroup('init.lua', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = augroup,
  callback = function()
    local git_dir = vim.fn.FugitiveGitDir()
    if git_dir == "" then
      return
    end
    if vim.fn.exists(git_dir) and vim.fn.executable(git_dir .. '/hooks/ctags') == 1 then
      vim.system({ git_dir .. '/hooks/ctags' })
    end
  end,
  desc = 'Regnerate ctags when in git repo',
})

-- spelling {{{2
-- -------------
vim.o.spellfile = vim.fn.stdpath('config') .. '/spell/myspell.utf-8.add'
vim.o.spell = true

-- source the init.lua file on save to apply all changes immediately {{{2
-- --------------------------------------------------------------------
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = 'init.lua',
  group = augroup,
  command = 'source ' .. vim.fn.stdpath('config') .. '/init.lua',
  desc = 'Source init.lua on change',
})

-- edit nvim config easily {{{2
-- -------------------------
vim.keymap.set('n', '<Leader>ed', '<cmd>split ~/.homesick/repos/dotfiles/home/<CR>')
vim.keymap.set('n', '<Leader>ev', '<cmd>split ~/.homesick/repos/dotfiles/home/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<Leader>ep', '<cmd>split ~/.homesick/repos/dotfiles/home/.config/nvim/lua/plugins/<CR>')

-- Use Vim's builtin help easily {{{2
-- ----------------------------------
vim.o.keywordprg = ':help'

-- When in a terminal, use parent vim as editor {{{2
-- -------------------------------------------------
vim.env.EDITOR = 'nvim --server $NVIM --remote'
vim.env.VISUAL = vim.env.EDITOR
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'gitcommit', 'gitrebase', 'gitconfig' },
  group = augroup,
  callback = function() vim.o.bufhidden = 'delete' end,
})


-- modeline {{{1
-- vim: set foldmethod=marker et sw=2 sts=2:
