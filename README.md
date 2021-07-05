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
- `rust` / [`rustup`](curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh)
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
- `tmux`
- `tmuxp`
- `mycli`

- `universal-ctags`
- `gotags`


## Neovim setup

```bash
# Install neovim normally through apt
sudo apt install neovim

# Install neovim by directly downloading AppImage (fallback)
# Better don't try snap, will have a lot of permission issues when using as system editor
# Also AppImage will not need root permission, if you cannot do apt you most certainly cannot do snap
mkdir -p $HOME/.local/bin && curl -L https://github.com/neovim/neovim/releases/download/v0.4.4/nvim.appimage -o $HOME/.local/bin/nvim && chmod +x $HOME/.local/bin/nvim

# Install neovim v0.5.0 as nvim5, currently only installable using AppImage
mkdir -p $HOME/.local/bin && curl -L https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage -o $HOME/.local/bin/nvim5 && chmod +x $HOME/.local/bin/nvim5

# Neovim vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'



# Vim vim-plug (fallback)
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Vundle (fallback)
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# nvim +PluginInstall # should not be required, Plug installes all packages automatically
# YouCompleteMe take sometime to download, 
# should be commented out from .vimrc if fast access is required
```

## YouCompleteMe Setup
```bash
cd ~/.vim/bundle/YouCompleteMe
./install.py --clangd-completer --rust-completer \
  --ts-completer --go-completer --java-completer
# --cs-completer for C# support

# Use this if you got an error mentioning npm cannot find tsserver
cd ~/.vim/bundle/YouCompleteMe/third_party/ycmd
npm install -g --prefix third_party/tsserver typescript
# Also try not to use NodeSource's distribution since it does not provides a 
# nodejs (node only) command for some reason and therefore breaks the install 
script for tsserver. It is tested that Ubuntu 20.10's native nodejs npm yarn 
package is more than enough.
```

## Tmux Setup
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux
# Crtl+B I to start installing
# Crtl+B U to start updating
# Crtl+B Alt u to start tidying
```

### Commands for installation

```bash
# Rustup (Not usable on Termux)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Flutter
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:`pwd`/flutter/bin"
flutter precache

# Use npm global without root
npm config set prefix '~/.local/'
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

## Developing Flutter apps on an Android device
1. Install `termux` on the andorid device.
2. Create a GCP VM (probably preemptible), let's make it `cloudvm`.
3. Turn on wireless debugging on your Android phone (require Android 11+).
4. Allow current Wi-Fi network.
5. You will get an "IP address & Port" for connection, let's make it `192.168.1.99:45678` here.
6. If this is the first time you have went through this process, you will also need to pair your phone with the cloud VM first, select "Pair device with pairing code", you can see another ip address and port, as well as a pairing code. Let's make it `192.168.1.99:23456` and `123456` here.
7. If you don't have the latest version of adb, you need to install it manually, as the version provided by adb is probably outdated and will not have the `adb pair` command aviliable. You may get it by, on your Cloud VM, `cd /tmp/asdkdowm && curl -O https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip && unzip commandlinetools-linux-7302050_latest.zip`, such that you will have an `./sdkmanager` command you can use, in which you can download the required Android Sdk components by `./sdkmanager --sdk_root=$HOME/Android/Sdk "platform-tools" "platforms;android-30" "build-tools;30.0.3"`. You may also need to accept all the licenses before you can use it.
8. On Cloud VM, redirect all of the outgoing connections to of all ports to `192.168.1.99` by running `sudo iptables -t nat "A" OUTPUT -p all -d "192.168.1.99" -j DNAT --to-destination 127.0.0.1`, change A to D for deleting this redirection. (`cloudvmrtl A|D 192.168.1.99`)
9. On termux of the Android device, setup headless SSH port forwarding by running `gcloud beta compute ssh username@cloudvm -- -f -N -R localhost:45678:192.168.1.99:45678 -R localhost:23456:192.168.1.99:23456`. You can list all of these headless SSH port forwarding background process by `ps -e -f | grep -- '-f -N'` and then run `kill` on each of them. (It is also possible to just do `pkill` on them, but it would also nuke all other similar SSH process on the VM, which is dangerous. It is also not necessary to port forward the port for pairing after you have went through the pairing process) (`cloudvmpf R 192.168.1.99 23456 45678` / `cloudvmpfls`)
10. If you haven't done the pairing yet, do the pairing on Cloud VM with `adb pair 192.168.1.99:23456 123456`.
11. On the VM, connect to the Android device by running `adb connect 192.168.1.99:45678`. Run `flutter devices` to verify you have already connected, then you can just do the normal development with flutter. It is also possible to develop for flutter web on the Android device if you do a extra SSH port forwarding.
12. It is currently not possible to do wireless debugging without connecting to a Wi-Fi network, however it should be possible to implement it. If it is implmented, then you won't even need to do the iptable NAT routing since it is used for preventing Android device complain about source IP address mismatch. Currently, if you do not do that mapping and simply do `adb connect 127.0.0.1:45678`, you will be able to connect to the Android device, but it won't allow it since you are using `127.0.0.1` instead of `192.168.1.99` which is not what it provies to you.


## Notes
- I have a few scripts to reduce the amount of keystrokes I need to achieve certain commands here, instructions for using my own scripts maybe aviliable for some command here, however they are not open-sourced here since those are customized for my own workflow and would not be useful for others. However it should not be hard to write your own scripts that run the command provided by me.
- Useful script get getting script parent dir: `SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"`
- Disable touchpad while typing: `gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing true`
