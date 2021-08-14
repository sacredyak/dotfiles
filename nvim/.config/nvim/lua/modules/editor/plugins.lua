local editor = {}
local conf = require('modules.editor.config')

editor['windwp/nvim-autopairs'] = {
  event = 'VimEnter',
  config = conf.autopairs,
}

editor['camspiers/snap'] = {
  event = 'VimEnter',
  config = conf.snap,
}

-- editor['nvim-telescope/telescope.nvim'] = {
--   cmd = 'Telescope',
--   config = conf.telescope,
--   requires = {
--     {'nvim-lua/popup.nvim', opt = true},
--     {'nvim-lua/plenary.nvim',opt = true},
--     {'nvim-telescope/telescope-fzf-writer.nvim', opt = true},
--   }
-- }

editor['editorconfig/editorconfig-vim'] = {
  ft = { 'go','vim','rust' }
}

editor["mcchrish/nnn.vim"] = {
  cmd = 'NnnPicker',
}

-- editor["easymotion/vim-easymotion"] = {
--   event = {'BufReadPre','BufNewFile'},
--   setup = conf.easymotion
-- }

editor["justinmk/vim-sneak"] = {
  event = {'BufReadPre','BufNewFile'},
  setup = conf.sneak
}

editor['wincent/scalpel'] = {
  event = {'BufReadPre','BufNewFile'},
  setup = conf.scalpel,
}

editor['haya14busa/vim-asterisk'] = {
  event = {'BufReadPre','BufNewFile'},
  setup = vim.cmd[[let g:asterisk#keeppos = 1]],
}

editor['machakann/vim-sandwich'] = {
  event = {'BufReadPre','BufNewFile'},
}

editor['1bharat/vim-multiple-cursors'] = {
  event = {'BufReadPre','BufNewFile'},
  setup = conf.multi,
}

editor['wellle/targets.vim'] = {
  event = {'BufReadPre','BufNewFile'},
}

editor['rhysd/accelerated-jk'] = {
  opt = true,
}

editor['andymass/vim-matchup'] = {
  event = {'BufReadPre','BufNewFile'},
  opt = true,
  setup = conf.matchup,
}

return editor
