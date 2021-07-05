set nocompatible              " be iMproved, required

" Plugin management with vim-plug

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'

Plug 'kabouzeid/nvim-lspinstall'

Plug 'tpope/vim-fugitive'

Plug 'fatih/vim-go'

" Plug 'ycm-core/YouCompleteMe'

Plug 'preservim/nerdtree'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Plug 'mg979/vim-visual-multi'


Plug 'tpope/vim-eunuch'

Plug 'tpope/vim-surround'

Plug 'editorconfig/editorconfig-vim'

Plug 'airblade/vim-gitgutter'

" Plug 'preservim/nerdcommenter'

Plug 'christoomey/vim-tmux-navigator'

" Plug 'xolox/vim-session'

Plug 'xolox/vim-misc'

Plug 'tpope/vim-commentary'

Plug 'jiangmiao/auto-pairs'

" Plug 'preservim/tagbar'

Plug 'Yggdroot/indentLine'

Plug 'dart-lang/dart-vim-plugin'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-obsession'
Plug 'puremourning/vimspector'

Plug 'sebdah/vim-delve'

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

Plug 'nvim-lua/popup.nvim'

Plug 'nvim-lua/plenary.nvim'

Plug 'akinsho/flutter-tools.nvim'

Plug 'mfussenegger/nvim-dap'

Plug 'rcarriga/nvim-dap-ui'

Plug 'nvim-telescope/telescope.nvim'

Plug 'embear/vim-localvimrc'

Plug 'hrsh7th/nvim-compe'

call plug#end()

" lsp config
lua << EOF
local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{}
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

require("flutter-tools").setup {
    debugger = {
      enabled = true,
    },
    flutter_path = "/home/michaellee8/.local/lib/flutter/bin/flutter",
    dev_tools = {
      autostart = true,
    },
}

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}


EOF

" gopls daemon mode

let g:go_gopls_enabled = 1
let g:go_gopls_options = ['-remote=auto']
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_referrers_mode = 'gopls'

let g:ycm_gopls_args = ['-remote=auto']

let g:ycm_language_server = [
  \   {
  \     'name': 'dart',
  \     'cmdline': ['dart', '/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot', '--lsp'],
  \     'filetypes': ['dart'],
  \   },
  \   {
  \     'name': 'yaml',
  \     'cmdline': ['yaml-language-server', '--stdio'],
  \     'filetypes': ['yaml', 'yml'],
  \   },
  \ ]

" custom key bindings

nmap <F8> :TagbarToggle<CR>

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

map <C-n> :NERDTreeToggle<CR>
map <leader><C-n> :NERDTreeToggleVCS<CR>
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" code style settings

set colorcolumn=80
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set mouse=a

" NERDTree settings

let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1

set number relativenumber

set filetype

" status line full file path
set statusline+=%F

" YouCompleteMe key bindings and settings
" nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
" nnoremap <leader>gd :YcmCompleter GoTo<CR>

" nnoremap <leader>ycfi :YcmCompleter FixIt<CR>
" nnoremap <leader>ycrr :YcmCompleter RefactorRename<CR>
" nnoremap <leader>ycdo :YcmCompleter GetDoc<CR>

nnoremap ycgr :YcmCompleter GoToReferences<CR>
nnoremap ycgi :YcmCompleter GoToImplementation<CR>
nnoremap ycgc :YcmCompleter GoToDeclaration<CR>
nnoremap ycgf :YcmCompleter GoToDefinition<CR>
nnoremap ycgt :YcmCompleter GoToType<CR>
nnoremap ycgd :YcmCompleter GoTo<CR>

nnoremap ycfi :YcmCompleter FixIt<CR>
nnoremap ycrr :YcmCompleter RefactorRename
nnoremap ycdo :YcmCompleter GetDoc<CR>

nmap ycfw <Plug>(YCMFindSymbolInWorkspace)
nmap ycfd <Plug>(YCMFindSymbolInDocument)


" nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
" nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>

let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" session.vim settings
" let g:session_default_to_last = 1

" let g:vimspector_enable_mappings = 'HUMAN'

" custom double leader mapping for vimspector, based on the 'HUMAN' config, to
" avoid collision with tagbar

nmap <leader><F5>         <Plug>VimspectorContinue
nmap <leader><leader><F5> <Plug>VimspectorLaunch
nmap <leader><F3>         <Plug>VimspectorStop
nmap <leader><F4>         <Plug>VimspectorRestart
nmap <leader><F6>         <Plug>VimspectorPause
nmap <leader><F9>         <Plug>VimspectorToggleBreakpoint
nmap <leader><leader><F9> <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader><F8>         <Plug>VimspectorAddFunctionBreakpoint
nmap <leader><leader><F8> <Plug>VimspectorRunToCursor
nmap <leader><F10>        <Plug>VimspectorStepOver
nmap <leader><F11>        <Plug>VimspectorStepInto
nmap <leader><F12>        <Plug>VimspectorStepOut

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" global 2 spaces indent
set tabstop=2 shiftwidth=2 expandtab

" filetype specific settings
autocmd Filetype yml setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 expandtab

set tabstop=2 shiftwidth=2 expandtab

