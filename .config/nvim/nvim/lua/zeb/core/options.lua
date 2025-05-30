vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

vim.o.guicursor =
	"n-v-c:hor10-blinkon500-green,i-ci:hor10-blinkon500-yellow,r-cr:hor10-blinkon500-red,o:hor10-blinkon500-blue,v:hor10-blinkon500-purple"

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- Set up the cursor in different modes with specific colors
-- vim.o.guicursor = "n-v-c:hor20-Cursor,i-ci:hor20-iCursor,r-cr:hor20-rCursor"

-- Define highlight groups for cursor
-- vim.api.nvim_set_hl(0, "Cursor", { fg = "NONE", bg = "#FFFFFF", gui = "NONE" }) -- White cursor for normal mode
-- vim.api.nvim_set_hl(0, "iCursor", { fg = "NONE", bg = "#00FF00", gui = "NONE" }) -- Green cursor for insert mode
-- vim.api.nvim_set_hl(0, "rCursor", { fg = "NONE", bg = "#FF0000", gui = "NONE" }) -- Red cursor for replace mode

--------- neovide stuff
if vim.g.neovide then
	vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

	-- Allow clipboard copy paste in neovim

	vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

	vim.o.guifont = "IosevkaTermSlab Nerd Font Mono:14" -- text below applies for VimScript

	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_cursor_animation_length = 0.02
	vim.g.neovide_cursor_trail = 0.4

	vim.g.neovide_cursor_vfx_mode = "railgun"
	--	vim.g.neovide_cursor_vfx_mode = "torpedo"
	--	vim.g.neovide_cursor_vfx_mode = "pixiedust"
	--  vim.g.neovide_cursor_vfx_mode = "sonicboom"
	--  vim.g.neovide_cursor_vfx_mode = "ripple"
	-- vim.g.neovide_cursor_vfx_mode = "wireframe"

	vim.g.neovide_hide_mouse_when_typing = true

	vim.g.neovide_opacity = 1 --  Adjust between 0.0 (fully transparent) to 1.0 (opaque)

	vim.g.neovide_floating_blur_amount_x = 0.0
	vim.g.neovide_floating_blur_amount_y = 0.0
end
