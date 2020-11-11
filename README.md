# Michaellee8's Public Environment Config

Copy the config files in repo root to `$HOME` before bootstraping.

## Phisoliphy

My phisoliphy in my own environment configuration is to be 
portable and progressive, which means that I am always trying to extend editor/tools defaults instead of using my own 
configuration, so that things will still more or kess work for 
me even in an environment that I don't get these setup. I am 
also trying to utilize trusted and managed components instead of 
components pulled from some random guy's github or npm, which 
may not be well maintained or even contain security issues, 
either intentional or careless. 

## Packages to install

- `golang`
- `clang`
- `gcc`
- `nodejs`
- `yarn`
- `python3`
- `python`
- `rust` / `rustup`
- `openjdk-8-jdk` / `openjdk-11-jdk`
- `dart` / `flutter`
- `google-cloud-sdk`

- `cmake`
- `bash`
- `autotools`
- `make`
- `build-essentials`
- `ninja` / `gn` / `bazel`
- `tput` / `ncurses-utilities`
- `wget` / `curl`
- `watchman`
- `pandoc` + `texlive` / `texlive-full`

- `vim-nox` / `vim-python` / `vim-gtk3`
- `neovim`
- `vifm`


## Vim/Neovim setup

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall
# YouCompleteMe take sometime to download, 
# should be commented out from .vimrc if fast access is required
```

## YouCompleteMe Setup
```bash
cd ~/.vim/bundle/YouCompleteMe
./install.py --clangd-completer --rust-completer \
  --ts-completer --go-completer --java-completer
# --cs-completer for C# support
```

## Tmux Setup
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux
# Crtl+B I to start installing
# Crtl+B U to start updating
# Crtl+B Alt u to start tidying
```

## Neovim Setup

Neovim is generally recommended over Vim since it is newer, 
less suprises, easily aviliable on old machines with AppImage 
more community-driven, nice built-in touch/mouse support even for
Termux and a better website. Most importantly a build-in cheatsheet via `:help quickref`.

### Install without root

Not recommended if have root access and the OS package manager is 
avilable, but useful to get an usable editor on shared machine. 
There are always some antique old Departmemt server that your course forces you to use which is running a Debian 8 server with a Vim 7.x compiled in 2020(seriously?), a version that is so old that 99% of plugins won't work. This is how `nvim` comes to rescue.

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv ./nvim.appimage ~/.local/bin/nvim
```

### Setting up plugin clients for different languages
```
pip3 install pynvim
yarn global add neovim
```

### Sharing `gopls`

- https://github.com/golang/tools/blob/master/gopls/doc/daemon.m
- https://github.com/fatih/vim-go/issues/2760
- `gopls -remote=auto -logfile=auto -debug=:0 -remote.debug=:0 -rpc.trace`
- https://github.com/ycm-core/ycmd/issues/1424

### Coc.nvim

Coc.nvim is a very nice plugin that take advantage of VSCode's 
ecosystem to get those goodies to Neovim. However, I am not so comfortable about the security of the NPM ecosystem it relies on 
(you are basically running hundreds if not thousands of random 
guys' code with your daily editor), and the fact that how Node.js is resource hungry (I need to use the same environment from some 
64GB RAM Intel Xeon Google Cloud instance to my 4GB RAM Android tablet running some Samsung CPU that Samsung only uses for low-end 
products), it is not preferred over YouCompleteMe unless some 
features from VSCode extensions are really required.

Add this line to `.vimrc`

```vimrc
Plugin 'neoclide/coc.nvim'
```

Useful commands:

```
:CocInstall coc-language` for each language you need.
:CocInstall coc-marketplace
:CocList marketplace
:CocList marketplace lang
```

