local opt = vim.opt

opt.background = "dark"
opt.backup = false
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.ignorecase = true
opt.linebreak = true
opt.list = true
opt.listchars = {
  trail = "-",
  eol = "¬",
  tab = "▸ ",
  extends = "»",
  precedes = "«"
}
opt.number = true
opt.scrolloff = 8
opt.shiftwidth = 2
opt.sidescrolloff = 8
opt.shortmess:append "Ic"
opt.showbreak = "↪"
opt.showmatch = true
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.timeout = true
opt.timeoutlen = 1000
opt.ttimeoutlen = 10
opt.updatetime = 500
opt.whichwrap = "b,s,[,],<,>"
opt.wrap = true
opt.wrapscan = true
opt.writebackup = false
