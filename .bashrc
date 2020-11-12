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

