#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export EDITOR=vim

alias off='sudo shutdown -h now'
alias fetch='/home/ht/gits/fetch.sh/./fetch.sh'
alias in='pacman -Qq'
alias inr='pacman -Qq | wc -l'
alias sw='cd ~/Pictures/Screenshots && sleep 5 && maim -i $(xdotool getactivewindow) "$(date +%Y-%m-%d_%H:%M:%S).png"'
alias sa='cd ~/Pictures/Screenshots && sleep 3 && maim -s "$(date +%Y-%m-%d_%H:%M:%S).png"'
alias afk='i3lock -c 000000'
alias yt='ytfzf -tf'
alias mp3='yt-dlp -f 140'
#alias vim='nvim'
alias ls='ls --color=auto'
alias wdl='/home/ht/gits/waldl/./waldl'
alias suspend='systemctl suspend'
alias rec='ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0 -f pulse -i default -c:v libx264rgb -crf 0 -preset fast -color_range 2 output.mkv'

# PS1='[\u@\h \W] $'
# PS1='\e[1m\e[38;5;40m{\t}\e[0m\n\e[38;5;198m{\w}\e[0m\n\e[38;5;196m\e[0m\e[38;5;40m$\e[0m'
# PS1="\[\e[31m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[35m\]\W\[\e[m\] "

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="\[\e[37;40m\][\[\e[m\]\[\e[34m\]\A\[\e[m\]]-\[\e[35m\]\u\[\e[m\]-\[\e[32m\]\W\[\e[m\]:\[\e[33m\]\`parse_git_branch\`\[\e[m\]\\$ "

# ufetch
pfetch


# This is for theme.sh - "https://github.com/lemnos/theme.sh" to change the terminal color scheme.

if command -v theme.sh > /dev/null; then
	[ -e ~/.theme_history ] && theme.sh "$(theme.sh -l|tail -n1)"

	# Optional  

	bind -x '"\x0f":"theme.sh $(theme.sh -l|tail -n2|head -n1)"' #Binds C-o to the previously active theme.
	alias th='theme.sh -i'

	# Interactively load a light theme
	alias thl='theme.sh --light -i'

	# Interactively load a dark theme
	alias thd='theme.sh --dark -i'
fi


