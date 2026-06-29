 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#11131d',
    base01 = '#1e1f29',
    base02 = '#282934',
    base03 = '#8e8fa3',
    base04 = '#c4c5da',
    base05 = '#e2e1f0',
    base06 = '#e2e1f0',
    base07 = '#e2e1f0',
    base08 = '#ffb4ab',
    base09 = '#f3aeff',
    base0A = '#bbc3ff',
    base0B = '#bbc3ff',
    base0C = '#f3aeff',
    base0D = '#bbc3ff',
    base0E = '#bbc3ff',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e2e1f0',          bg = '#11131d' })
  hi('TelescopeBorder',         { fg = '#8e8fa3',             bg = '#11131d' })
  hi('TelescopePromptNormal',   { fg = '#e2e1f0',          bg = '#11131d' })
  hi('TelescopePromptBorder',   { fg = '#8e8fa3',             bg = '#11131d' })
  hi('TelescopePromptPrefix',   { fg = '#bbc3ff',             bg = '#11131d' })
  hi('TelescopePromptCounter',  { fg = '#c4c5da',  bg = '#11131d' })
  hi('TelescopePromptTitle',    { fg = '#11131d',             bg = '#bbc3ff' })
  hi('TelescopePreviewTitle',   { fg = '#11131d',             bg = '#bbc3ff' })
  hi('TelescopeResultsTitle',   { fg = '#11131d',             bg = '#f3aeff' })
  hi('TelescopeSelection',      { fg = '#e2e1f0',          bg = '#282934' })
  hi('TelescopeSelectionCaret', { fg = '#bbc3ff',             bg = '#282934' })
  hi('TelescopeMatching',       { fg = '#bbc3ff',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
