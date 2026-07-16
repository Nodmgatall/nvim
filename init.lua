print("init.lua loaded")
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true

require("config.lazy")
require("config.keybinds")

