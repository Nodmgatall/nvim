vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.termguicolors = true
vim.cmd.colorscheme("habamax")

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


require("config.lazy")
require("config.keybinds")
