local M = {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    label = {
      before = true,
      after = false,
    },
    highlight = {
      backdrop = false,
    },
    modes = {
      char = {
        highlight = {
          backdrop = false,
        },
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>j", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "<leader>J", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
return M
