require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.autocmds")

if vim.g.vscode then
  require("config.vscode")
end