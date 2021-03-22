set nocompatible              " be iMproved, required
filetype off                  " required

" Plugin management with Vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'


Plugin 'tpope/vim-fugitive'

Plugin 'fatih/vim-go'

Plugin 'ycm-core/YouCompleteMe'

Plugin 'preservim/nerdtree'

Plugin 'junegunn/fzf.vim'

" Plugin 'mg979/vim-visual-multi'

Plugin 'itchyny/lightline.vim'

Plugin 'tpope/vim-eunuch'

Plugin 'tpope/vim-surround'

Plugin 'editorconfig/editorconfig-vim'

Plugin 'airblade/vim-gitgutter'

Plugin 'preservim/nerdcommenter'

Plugin 'christoomey/vim-tmux-navigator'

Plugin 'xolox/vim-session'

Plugin 'xolox/vim-misc'

" Plugin 'tpope/vim-commentary'

Plugin 'jiangmiao/auto-pairs'

Plugin 'preservim/tagbar'

Plugin 'Yggdroot/indentLine'

Plugin 'dart-lang/dart-vim-plugin'

call vundle#end()            " required

filetype plugin indent on    " required

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
  \     'filetypes': [ 'dart' ],
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

set number relativenumber

set filetype

