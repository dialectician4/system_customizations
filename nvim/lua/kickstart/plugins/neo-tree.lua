-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    auto_close_on_select = false,
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['O'] = 'open_nofocus',
        },
      },
      commands = {
        open_nofocus = function(state)
          require('neo-tree.sources.filesystem.commands').open(state)
          vim.schedule(function()
            vim.cmd [[Neotree focus]]
          end)
        end,
      },
    },
  },
}
