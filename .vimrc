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

" Plugin 'tpope/vim-commentary'



call vundle#end()            " required

filetype plugin indent on    " required

" gopls daemon mode

let g:go_gopls_enabled = 1
let g:go_gopls_options = ['-remote=auto']
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_referrers_mode = 'gopls'

let g:ycm_gopls_args = ['-remote=auto']

" custom key bindings

map <C-n> :NERDTreeToggle<CR>

" code style settings

set colorcolumn=80
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set mouse=a

" NERDTree settings

let NERDTreeShowHidden=1

set number relativenumber
