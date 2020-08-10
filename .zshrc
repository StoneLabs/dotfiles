# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZSH CUSTOMS
ZSH_CUSTOM=$HOME/.zsh_customs

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="stone"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=()

source $ZSH/oh-my-zsh.sh

##
## ALIAS
##

alias teamspeak5=~/teamspeak5/TeamSpeak

##
## TRANSFER FUNCTIONS
##

transfer() { 
	if [ $# -eq 0 ]; then
		echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; 
		return 1; 
	fi 
	tmpfile=$( mktemp -t transferXXX ); 
	if tty -s; then 
		basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
		curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
	else 
		curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile;
	fi;
	cat $tmpfile;
	rm -f $tmpfile;
} 

##
## COUNTDOWN FUNCTIONS
##

function __echo_h {

  text="$1"

  cols=`tput cols`

  IFS=$'\n'$'\r'
  for line in $(echo -e $text); do

    line_length=`echo $line| wc -c`
    half_of_line_length=`expr $line_length / 2`
    center=`expr \( $cols / 2 \) - $half_of_line_length`

    spaces=""
    for ((i=0; i < $center; i++)) {
      spaces="$spaces "
    }

    echo "$spaces$line"

  done

  unset text
  unset cols
  unset IFS
  unset line_length
  unset half_of_line_length
  unset center
  unset spaces
  unset i
}

function __echo_v {

  text=$1

  rows=`tput lines`

  text_length=`echo -e $text | wc -l`
  half_of_text_length=`expr $text_length / 2`

  center=`expr \( $rows / 2 \) - $half_of_text_length`

  lines=""

  for ((i=0; i < $center; i++)) {
    lines="$lines\n"
  }

  echo -e "$lines$text$lines"

  unset i
  unset text
  unset rows
  unset text_length
  unset half_of_text_length
  unset center
  unset ilines
}

function __echo_c {
  __echo_v "`__echo_h $1`"
}

countdown() {
	__red_on_black="\e[31m"
	__black_on_red="\e[41;30m"
	__reset_colors="\e[49;39m"
	if [ $# -eq 0 ]; then
		echo -e "No arguments specified. Usage:\ncountdown 30 \"Text: \"";
		return 1;
	fi
	target_epoch=$((`date +%s` + $1)); 

	while :; do
		diff=$(($target_epoch - `date +%s` ))
		
		if [ $diff -ge 0 ]; then
			[ $(($diff % 2)) -eq 0 ] && [ $(($diff)) -le 10 ] && echo -en $__red_on_black
			__echo_c $(date -u -d @$diff +"%T")
		else

			[ $(($diff % 2)) -eq 0 ] && [ $(($diff)) -le 10 ] && echo -en $__black_on_red		
			__echo_c '########################################\nALARM\n########################################'
		fi
		[ $(($diff % 2)) -eq 0 ] && [ $(($diff)) -le 10 ] && echo -en $__reset_colors
	
		sleep 0.1
	done
}

##
## VM resolution force
##

setvmres() {
	xrandr --newmode "1920x1080_60.00"  172.80  1920 2040 2248 2576  1080 1081 1084 1118  -HSync +Vsync
	xrandr --addmode Virtual-1 "1920x1080_60.00"
	xrandr --output Virtual-1 --mode "1920x1080_60.00"
}
