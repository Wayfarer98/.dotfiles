local M = {
	'mbbill/undotree',
	enabled = function()
		return vim.g.vscode == nil
	end,

}
return M
