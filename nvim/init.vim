" ============================================================
" Basic settings
" ============================================================
set nocompatible
set encoding=utf-8
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set hidden
set termguicolors
set background=dark
set clipboard=unnamedplus

let mapleader = " "

filetype plugin indent on


" ============================================================
" Plugin manager
" ============================================================
call plug#begin('~/.local/share/nvim/plugged')

" Terminal
Plug 'akinsho/toggleterm.nvim', {'tag': '*'}

" Completion without LSP
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'

" Utilities
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()


" ============================================================
" UI / colors
" ============================================================
highlight Normal       guifg=#e6e6e6 guibg=NONE
highlight NonText      guifg=#555555 guibg=NONE
highlight LineNr       guifg=#808080 guibg=NONE
highlight CursorLine                 guibg=#111111
highlight CursorLineNr guifg=#e6e6e6 guibg=NONE
highlight Visual                     guibg=#334466
highlight Comment      guifg=#a0a0a0 gui=italic

highlight NormalFloat  guifg=#e6e6e6 guibg=#050505
highlight FloatBorder  guifg=#777777 guibg=#050505

highlight TermNormal   ctermfg=15 ctermbg=NONE cterm=bold
highlight TermNormalNC ctermfg=7  ctermbg=NONE
highlight TermCursor   ctermfg=0  ctermbg=15

highlight Pmenu        guifg=#e6e6e6 guibg=#1e1e1e
highlight PmenuSel     guifg=#000000 guibg=#ffd787
highlight PmenuSbar                  guibg=#404040
highlight PmenuThumb                 guibg=#808080


" ============================================================
" Shim for dev build without vim.version
" ============================================================
lua <<EOF
local ok = pcall(require, "vim.version")
if not ok then
  package.preload["vim.version"] = function()
    local v = {}
    if vim.version then
      local ok2, real = pcall(vim.version)
      if ok2 and type(real) == "table" then
        v = real
      end
    end
    v.prerelease = v.prerelease or "dev"
    return v
  end
end
EOF


" ============================================================
" toggleterm
" ============================================================
lua <<EOF
local ok, toggleterm = pcall(require, "toggleterm")
if ok then
  toggleterm.setup{
    direction = "vertical",
    open_mapping = [[<c-\>]],
    size = function(term)
      if term.direction == "vertical" then
        return math.floor(vim.o.columns / 2)
      elseif term.direction == "horizontal" then
        return 15
      end
      return 80
    end,
  }
end
EOF

tnoremap <silent> <ESC> <C-\><C-n>


" ============================================================
" nvim-cmp without LSP
" ============================================================
lua <<EOF
local ok_cmp, cmp = pcall(require, "cmp")
if ok_cmp then
  local ok_luasnip, luasnip = pcall(require, "luasnip")

  cmp.setup({
    snippet = {
      expand = function(args)
        if ok_luasnip then
          luasnip.lsp_expand(args.body)
        end
      end,
    },
    mapping = {
      ['<Down>']  = cmp.mapping.select_next_item(),
      ['<Up>']    = cmp.mapping.select_prev_item(),
      ['<Tab>']   = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<CR>']    = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'buffer' },
      { name = 'path' },
    },
  })
end
EOF


" ============================================================
" Treesitter
" ============================================================
lua <<EOF
local ok_ts, configs = pcall(require, "nvim-treesitter.configs")
if ok_ts then
  configs.setup{
    highlight = { enable = true },
    indent    = { enable = true },
  }
end
EOF


" ============================================================
" Unified REPL launcher + <C-e> send
" ============================================================
function! ReplStart(cmd)
  if !exists('b:repl_opened') || !b:repl_opened
    let b:repl_opened = 1
    execute 'TermExec cmd="' . a:cmd . '" direction=vertical'
  endif
endfunction

function! ReplSendLine(cmd)
  call ReplStart(a:cmd)
  execute 'ToggleTermSendCurrentLine'
  normal! j^
endfunction

function! ReplSendSelection(cmd) range
  call ReplStart(a:cmd)
  execute 'ToggleTermSendVisualSelection'
  normal! '>j^
endfunction

augroup ReplMappings
  autocmd!
  autocmd FileType r nnoremap  <buffer> <silent> <C-e> :call ReplSendLine('R --vanilla')<CR>
  autocmd FileType r vnoremap  <buffer> <silent> <C-e> :<C-u>call ReplSendSelection('R --vanilla')<CR>

  autocmd FileType python nnoremap <buffer> <silent> <C-e> :call ReplSendLine('python3')<CR>
  autocmd FileType python vnoremap <buffer> <silent> <C-e> :<C-u>call ReplSendSelection('python3')<CR>

  autocmd FileType sh,bash,zsh nnoremap <buffer> <silent> <C-e> :call ReplSendLine('bash')<CR>
  autocmd FileType sh,bash,zsh vnoremap <buffer> <silent> <C-e> :<C-u>call ReplSendSelection('bash')<CR>
augroup END

augroup TermAutoInsert
  autocmd!
  autocmd TermOpen  * startinsert
  autocmd TermEnter * startinsert
augroup END

augroup NoMouseInTerm
  autocmd!
  autocmd TermOpen * setlocal mouse=
augroup END

tnoremap <silent> <C-e><C-e> <C-\><C-n><C-w>h
