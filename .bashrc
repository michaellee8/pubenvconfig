if [ -x "$(command -v tput)" ]; then
	export PS1="\[$(tput bold)$(tput setaf 7)\]\[$(tput setaf 2)\]\u@\[$(tput setaf 6)\]\h:\[$(tput setaf 4)\]\w $ \[$(tput sgr0)\]"
fi

vicd()
{
	local dst="$(command vifm --choose-dir - "$@")"
	if [ -z "$dst" ]; then
		echo 'Directory picking cancelled/failed'
		return 1
	fi
	cd "$dst"
}

# Temporially disabled before neovim 0.5.0 is in Ubuntu apt
# if [ -x "$(command -v nvim)" ]; then
#   export EDITOR=nvim
# fi
if [ -x "$(command -v vim)" ]; then
  export EDITOR=vim
fi

# Configure all Android SDK binaries
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

