if vim.g.vscode then

else
	-- Remap space as leader key
	

	vim.opt.nu = true
	vim.opt.rnu = true

	vim.opt.tabstop = 4
	vim.opt.softtabstop = 4
	vim.opt.shiftwidth = 4
	vim.opt.expandtab = true

	vim.opt.smartindent = true

	vim.opt.wrap = false

	vim.opt.swapfile = false
	vim.opt.backup = false
	vim.opt.undofile = true

	vim.opt.incsearch = true

	vim.opt.termguicolors = true

	vim.opt.scrolloff = 8
	vim.opt.signcolumn = "yes"

	vim.opt.updatetime = 50

	vim.opt.colorcolumn = "80"

	vim.opt.showmode = false

	-- Decrease update time
	vim.o.updatetime = 500
	vim.o.timeoutlen = 300
	vim.o.mousemoveevent = true

	-- Set completeopt to have a better completion experience
	vim.o.completeopt = 'menuone,noselect'


	vim.diagnostic.config({
		virtual_text = false,
		signs = true,
		update_in_insert = true,
	})
end
vim.g.mapleader = " "
vim.g.maplocalleader = " "
