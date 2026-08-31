local colorcycle = require("config.colorscheme_cycle")
vim.keymap.set("n", "<Leader>k", colorcycle.next_colorscheme, { desc = "Next colorscheme" })
vim.keymap.set("n", "<Leader>cp", colorcycle.prev_colorscheme, { desc = "Previous colorscheme" })

vim.keymap.set('n', '<Leader>e','<cmd>NERDTreeToggle<cr>')
vim.keymap.set('n', '<Leader>t','<cmd>TagbarToggle<cr>')
vim.keymap.set('n', '<Leader>E','<cmd>TagbarToggle<cr><bar><cmd>NERDTreeToggle<cr> ')

if vim.bo.filetype ~= "rust" then
vim.keymap.set("n", "<Leader>f", function()
    if vim.bo.filetype ~= "rust" then
        return
    end

    echot "rst fmt"
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local input = table.concat(lines, "\n")

    local result = vim.system({ "rustfmt" }, { stdin = input, text = true }):wait()

    if result.code == 0 then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(result.stdout, "\n"))
    else
        vim.notify(result.stderr, vim.log.levels.ERROR)
    end
end, { desc = "Format Rust buffer" })
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		vim.keymap.set("n", "<Leader>f", "<cmd>RustFmt<cr>", { buffer = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		vim.keymap.set("n", "<Leader>f", "<cmd>ClangFormat<cr>", { buffer = true })
	end,
})
