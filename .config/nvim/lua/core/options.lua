local opt = vim.opt

-- インデント
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- 検索
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true

-- 表示
opt.background = "dark"
opt.cursorline = true
opt.list = true
opt.listchars = {
  trail = "-",
  eol = "¬",
  tab = "▸ ",
  extends = "»",
  precedes = "«"
}
opt.number = true
opt.showbreak = "↪"
opt.showmatch = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.wrap = true
opt.linebreak = true

-- ファイル
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- クリップボード
opt.clipboard = "unnamedplus"

-- その他
opt.shortmess:append "Ic"
opt.timeout = true
opt.timeoutlen = 1000
opt.ttimeoutlen = 10
opt.updatetime = 500
opt.whichwrap = "b,s,[,],<,>"
