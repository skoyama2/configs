set shiftwidth=4
set expandtab
set hidden
set termguicolors
set background=dark
set clipboard=unnamedplus

let mapleader = " "

" Enable filetype detection (required for FileType autocmd)
filetype plugin indent on

" ============================================================
" Plugin manager (vim-plug)
"   Run :PlugInstall after first start
" ============================================================
call plug#begin('~/.local/share/nvim/plugged')

" Terminal
Plug 'akinsho/toggleterm.nvim', {'tag': '*'}

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'

" LSP configs
Plug 'neovim/nvim-lspconfig'

" Utilities
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()


" ============================================================
" UI / colors (let terminal provide background)
" ============================================================
" Do NOT call :syntax on / syntax reset here (runtime is broken on this cluster)
highlight Normal       guifg=#e6e6e6 guibg=NONE
highlight NonText      guifg=#555555 guibg=NONE
highlight LineNr       guifg=#808080 guibg=NONE
highlight CursorLine                 guibg=#111111
highlight CursorLineNr guifg=#e6e6e6 guibg=NONE
highlight Visual                     guibg=#334466
highlight Comment      guifg=#a0a0a0 gui=italic

highlight NormalFloat  guifg=#e6e6e6 guibg=#050505
highlight FloatBorder  guifg=#777777 guibg=#050505

" Terminal windows (make sure text is readable even with pale terminal theme)
highlight TermNormal   ctermfg=15 ctermbg=NONE cterm=bold
highlight TermNormalNC ctermfg=7  ctermbg=NONE
highlight TermCursor   ctermfg=0  ctermbg=15

" Completion popup (nvim-cmp)
highlight Pmenu        guifg=#e6e6e6 guibg=#1e1e1e
highlight PmenuSel     guifg=#000000 guibg=#ffd787
highlight PmenuSbar                  guibg=#404040
highlight PmenuThumb                 guibg=#808080

" ============================================================
" Shim for dev build without vim.version (needed by toggleterm)
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
" toggleterm settings (vertical split, half width, <C-\>)
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

" ESC in terminal mode -> normal mode
tnoremap <silent> <ESC> <C-\><C-n>

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

" Enable filetype detection (required for FileType autocmd)
filetype plugin indent on


" ============================================================
" Plugin manager (vim-plug)
"   Run :PlugInstall after first start
" ============================================================
call plug#begin('~/.local/share/nvim/plugged')

" Terminal
Plug 'akinsho/toggleterm.nvim', {'tag': '*'}

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'

" LSP configs
Plug 'neovim/nvim-lspconfig'

" Utilities
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()


" ============================================================
" UI / colors (let terminal provide background)
" ============================================================
" Do NOT call :syntax on / syntax reset here (runtime is broken on this cluster)
highlight Normal       guifg=#e6e6e6 guibg=NONE
highlight NonText      guifg=#555555 guibg=NONE
highlight LineNr       guifg=#808080 guibg=NONE
highlight CursorLine               guibg=#111111
highlight CursorLineNr guifg=#e6e6e6 guibg=NONE
highlight Visual                   guibg=#334466
highlight Comment      guifg=#a0a0a0 gui=italic

highlight NormalFloat  guifg=#e6e6e6 guibg=#050505
highlight FloatBorder  guifg=#777777 guibg=#050505

" Terminal windows (make sure text is readable even with pale terminal theme)
highlight TermNormal   ctermfg=15 ctermbg=NONE cterm=bold
highlight TermNormalNC ctermfg=7  ctermbg=NONE
highlight TermCursor   ctermfg=0  ctermbg=15

" Completion popup (nvim-cmp)
highlight Pmenu        guifg=#e6e6e6 guibg=#1e1e1e
highlight PmenuSel     guifg=#000000 guibg=#ffd787
highlight PmenuSbar                 guibg=#404040
highlight PmenuThumb               guibg=#808080


" ============================================================
" Shim for dev build without vim.version (needed by toggleterm)
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
" toggleterm settings (vertical split, half width, <C-\>)
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

" ESC in terminal mode -> normal mode
tnoremap <silent> <ESC> <C-\><C-n>


" ============================================================
" nvim-cmp (completion)
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
      -- arrows
      ['<Down>']  = cmp.mapping.select_next_item(),
      ['<Up>']    = cmp.mapping.select_prev_item(),

      -- Tab / Shift-Tab (今までどおり)
      ['<Tab>']   = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),

      -- Enter to confirm
      ['<CR>']    = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer'   },
      { name = 'path'     },
    },
  })
end
EOF


" ============================================================
" Treesitter (syntax & indent)
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
" LSP (new API: vim.lsp.config / vim.lsp.enable)
"   Requires:
"     Python:   python3 -m pip install --user pyright
"     R:        install.packages("languageserver", lib="~/R_LIBS")
"               and export R_LIBS=~/R_LIBS
" ============================================================
lua <<EOF
local has_lspconfig, _ = pcall(require, "lspconfig")
if has_lspconfig then
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  vim.lsp.config('*', {
    capabilities = capabilities,
  })

  -- Enable specific servers if available
  pcall(vim.lsp.enable, 'pyright')            -- Python
  pcall(vim.lsp.enable, 'r_language_server')  -- R (languageserver)
end
EOF

" Basic LSP keymaps
nnoremap <silent> gd        <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD        <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>


" ============================================================
" Unified REPL launcher + <C-e> send (R / Python / Shell)
"   - First <C-e>: open REPL in vertical toggleterm + send
"   - After that: send only
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
  " R (.R)
  autocmd FileType r nnoremap  <buffer> <silent> <C-e> :call ReplSendLine('R --vanilla')<CR>
  autocmd FileType r vnoremap  <buffer> <silent> <C-e> :<C-u>call ReplSendSelection('R --vanilla')<CR>

  " Python (.py)
  autocmd FileType python nnoremap <buffer> <silent> <C-e> :call ReplSendLine('python3')<CR>
  autocmd FileType python vnoremap <buffer> <silent> <C-e> :<C-u>call ReplSendSelection('python3')<CR>

  " Shell (.sh, .bash, .zsh)
  autocmd FileType sh,bash,zsh nnoremap <buffer> <silent> <C-e> :call ReplSendLine('bash')<CR>
  autocmd FileType sh,bash,zsh vnoremap <buffer> <silent> <C-e> :<C-u>call ReplSendSelection('bash')<CR>
augroup END

" Always stay in terminal-job (insert) mode in terminal buffers
augroup TermAutoInsert
  autocmd!
  autocmd TermOpen  * startinsert
  autocmd TermEnter * startinsert
augroup END

augroup NoMouseInTerm
  autocmd!
  autocmd TermOpen * setlocal mouse=
augroup END

" In terminal (insert/job mode), <C-e><C-e> -> go back to the left Vim window
tnoremap <silent> <C-e><C-e> <C-\><C-n><C-w>h

" ESC in terminal mode -> normal mode
tnoremap <silent> <ESC> <C-\><C-n>


" ============================================================
" nvim-cmp (completion)
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
      -- arrows
      ['<Down>']  = cmp.mapping.select_next_item(),
      ['<Up>']    = cmp.mapping.select_prev_item(),

      -- Tab / Shift-Tab (今までどおり)
      ['<Tab>']   = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),

      -- Enter to confirm
      ['<CR>']    = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer'   },
      { name = 'path'     },
    },
  })
end
EOF

" ============================================================
" Treesitter (syntax & indent)
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
" LSP (new API: vim.lsp.config / vim.lsp.enable)
"   Requires:
"     Python:   python3 -m pip install --user pyright
"     R:        install.packages("languageserver", lib="~/R_LIBS")
"               and export R_LIBS=~/R_LIBS
" ============================================================
lua <<EOF
local has_lspconfig, _ = pcall(require, "lspconfig")
if has_lspconfig then
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  vim.lsp.config('*', {
    capabilities = capabilities,
  })

  -- Enable specific servers if available
  pcall(vim.lsp.enable, 'pyright')            -- Python
  pcall(vim.lsp.enable, 'r_language_server')  -- R (languageserver)
end
EOF

" Basic LSP keymaps
nnoremap <silent> gd        <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD        <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>


" ============================================================
" Unified REPL launcher + <C-e> send (R / Python / Shell)
"   - First <C-e>: open REPL in vertical toggleterm + send
"   - After that: send only
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
  " R (.R)
  autocmd FileType r nnoremap  <buffer> <silent> <C-e> :call ReplSendLine('R --vanilla')<CR>
  autocmd FileType r vnoremap  <buffer> <silent> <C-e> :<C-u>call ReplSendSelection('R --vanilla')<CR>

  " Python (.py)
  autocmd FileType python nnoremap <buffer> <silent> <C-e> :call ReplSendLine('python3')<CR>
  autocmd FileType python vnoremap <buffer> <silent> <C-e> :<C-u>call ReplSendSelection('python3')<CR>

  " Shell (.sh, .bash, .zsh)
  autocmd FileType sh,bash,zsh nnoremap <buffer> <silent> <C-e> :call ReplSendLine('bash')<CR>
  autocmd FileType sh,bash,zsh vnoremap <buffer> <silent> <C-e> :<C-u>call ReplSendSelection('bash')<CR>
augroup END

" Always stay in terminal-job (insert) mode in terminal buffers
augroup TermAutoInsert
  autocmd!
  autocmd TermOpen  * startinsert
  autocmd TermEnter * startinsert
augroup END

augroup NoMouseInTerm
  autocmd!
  autocmd TermOpen * setlocal mouse=
augroup END

" In terminal (insert/job mode), <C-e><C-e> -> go back to the left Vim window
tnoremap <silent> <C-e><C-e> <C-\><C-n><C-w>h

