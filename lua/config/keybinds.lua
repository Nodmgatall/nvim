print("keybinds loaded")
vim.g.mapleader = ","
vim.keymap.set('n', '<Leader>e','<cmd>NERDTreeToggle<cr>')
vim.keymap.set('n', '<Leader>t','<cmd>TagbarToggle<cr>')
vim.keymap.set('n', '<Leader>E','<cmd>TagbarToggle<cr><bar><cmd>NERDTreeToggle<cr> ')
