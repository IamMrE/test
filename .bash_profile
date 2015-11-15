

	PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
	PATH="~/.dircolors:$PATH"	
	PATH="/usr/bin/:$PATH"
	MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

     test -e ~/.dircolors && \
       eval `dircolors -b ~/.dircolors`
	eval $(dircolors -b $HOME/.dircolors)
    
    alias ls="ls --color=always" 
    alias grep="grep --color=always"
    alias egrep="egrep --color=always" 
    #alias echo="echo --color=always"
    
	# include .bash_aliases if it exists
	if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
	fi
	
######################################################################################################################################################
#----- CUSTOM STARTS HERE ------ CUSTOM STARTS HERE ------ CUSTOM STARTS HERE ------ CUSTOM STARTS HERE ------ CUSTOM STARTS HERE ------ CUSTOM
######################################################################################################################################################
function __setprompt
{
	last_command=$? # Must come first!

	# Define colors
	##### Selected 256 color palette with easy names see function colors2num for more colors ######
	# basic colors: (insert ';1' before the last 'm' to get bold(=thicker) variants, i.e. bred='\033[38;05;1;1m'...)
	red="\033[38;05;124m"
	grn="\033[38;05;2m"
	yel="\033[38;05;3m"
	blu="\033[38;05;4m"		# ng for dark BG
	pnk="\033[38;05;5m"
	cya="\033[38;05;6m"
	wht="\033[38;05;7m"
	gry="\033[38;05;8m"		# good for not being distracting; subtle

	# intense colors: (same applies for intense and bold, i.e. bired="\033[38;05;9;1m"
	ired="\033[38;05;9m"
	igrn="\033[38;05;46m"
	iyel="\033[38;05;11m"
	iblu="\033[38;05;12m"		# still ng fpr dark BGs
	ipnk="\033[38;05;13m"
	icya="\033[38;05;14;1m"
	iwht="\033[38;05;15m"
	igry="\033[38;05;16m"		# essentially black; shows on grey BG
	iorg="\033[38;5;208m"

	# add'l colors I like/use:
	purp="\033[38;05;4m"		# reg purple
	dpur="\033[38;05;4;1m"		# deep purple (reg + bold)
	ipur="\033[38;05;4m"		# bright(er) purple
	bpur="\033[38;05;4;1m"		# bright + bold
	mgrn="\033[38;05;28m"		# muted green for exit status fill line
	bgrn="\033[38;05;10;1m"		# bright + bold green
	borg="\033[38;5;208;1m"
	bpnk="\033[38;5;165;1m"
	rset="\033[0m"
	
	# create a $fill of all screen width minus the time string and a space:

	let fillsize=${COLUMNS}-12

	fill=""

	while [ "$fillsize" -gt "0" ]

	do

	fill="-${fill}" # fill with underscores to work on

	let fillsize=${fillsize}-1

	done

	# Show error exit code if there is one
	if [[ $last_command != 0 ]]; then
		
		PS1="\[${red}\]😡  $fill \@\n\[${gry}\][\[${red}\]Error \[${ired}\]${last_command}\[${gry}\]]-[\[${red}\]"
		
		if [[ $last_command == 1 ]]; then
			PS1+="General error"
		elif [ $last_command == 2 ]; then
			PS1+="Missing keyword, command, or permission problem"
		elif [ $last_command == 126 ]; then
			PS1+="Permission problem or command is not an executable"
		elif [ $last_command == 127 ]; then
			PS1+="Command not found"
		elif [ $last_command == 128 ]; then
			PS1+="Invalid argument to exit"
		elif [ $last_command == 129 ]; then
			PS1+="Fatal error signal 1"
		elif [ $last_command == 130 ]; then
			PS1+="Script terminated by Control-C"
		elif [ $last_command == 131 ]; then
			PS1+="Fatal error signal 3"
		elif [ $last_command == 132 ]; then
			PS1+="Fatal error signal 4"
		elif [ $last_command == 133 ]; then
			PS1+="Fatal error signal 5"
		elif [ $last_command == 134 ]; then
			PS1+="Fatal error signal 6"
		elif [ $last_command == 135 ]; then
			PS1+="Fatal error signal 7"
		elif [ $last_command == 136 ]; then
			PS1+="Fatal error signal 8"
		elif [ $last_command == 137 ]; then
			PS1+="Fatal error signal 9"
		elif [ $last_command -gt 255 ]; then
			PS1+="Exit status out of range"
		else
			PS1+="Unknown error code"
		fi
		PS1+="\[${gry}\]]\[${rset}\] try again? \n"
	else
		PS1="\[${grn}\]😎  $fill \@"
	fi

	# PS1+="\[${gry}\]["

	# User and server
	 SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
	 SSH2_IP=`echo $SSH2_CLIENT | awk '{ print $1 }'`
	  if [ $SSH2_IP ] || [ $SSH_IP ] ; then
		PS1+="\[${bgrn}\]\u\[${rset}\] remote on "
	  else
		PS1+="\[${bpur}\]\u\[${rset}\] is on "
	  fi

	# Date
	# PS1+="\[${DARKGRAY}\](\[${CYAN}\]\$(date +%a) $(date +%b-'%-m')" # Date
	# PS1+="${blu} $(date +'%-I':%M:%S%P)\[${gry}\])-" # Time

	# Host
	  PS1+="\[${borg}\]\h"		

	# CPU
	# PS1+="(\[${MAGENTA}\]CPU $(cpu)%"

	# Jobs
	# PS1+="\[${gry}\]:\[${MAGENTA}\]\j"

	# Network Connections (for a server - comment out for non-server)
	# PS1+="\[${gry}\]:\[${MAGENTA}\]Net $(awk 'END {print NR}' /proc/net/tcp)"

	# Current directory
	PS1+="\[${rset}\] in \[${icya}\]\w\[${rset}\] which has "

	# Number of files
	PS1+="\[${grn}\]\$(/bin/ls -A -1 | /usr/bin/wc -l)\[${rset}\] files using "	
	
	# Total size of files in current directory
	PS1+="\[${grn}\]$(/bin/ls -lah | /usr/bin/grep -m 1 total | /usr/bin/sed 's/total //') K\[${gry}\]"

	# Skip to the next line
	PS1+="\n"

	if [[ $EUID -ne 0 ]]; then
		PS1+="\[${grn}\]=> \[${rset}\]" # Normal user
	else
		PS1+="\[${ired}\]=> \[${rset}\]" # Root user
	fi
	
	# PS2 is used to continue a command using the \ character
	PS2="\[${gry}\]>\[${rset}\] "

	# PS3 is used to enter a number choice in a script
	PS3='Please enter a number from above list: '

	# PS4 is used for tracing a script in debug mode
	PS4='\[${gry}\]+\[${rset}\] '
	
	# Reset color for command output

	# this one is invoked every time before a command is executed:
	
	trap 'echo -ne "\033[38;05;27m"' DEBUG
}
PROMPT_COMMAND='__setprompt'
##################################################
#         End imatt(ux) custom PS1		         #
##################################################
##################################################

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
   alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

##########  Mac Specific Aliases & Functions ##########
alias list='diskutil list'
#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }

######################################################################################################################################################
#----- USEFUL FUNCTIONS ------ USEFUL FUNCTIONS  ------ USEFUL FUNCTIONS  ------ - USEFUL FUNCTIONS  ------######
######################################################################################################################################################

###### print all 256 colors for testing TERM or for a quick reference
# show numerical values for each of the 256 colors in bash
function colors2nums()
	{ for code in {0..255};
	do echo -e "\033[38;05;${code}m $code: Test";
	done 
	}

###### replaces a color in PDF document (useful for removing dark background for printing)
# usage:	remove_color input.pdf output.pdf
function uncolorpdf()
{
convert -density 300 "$1" -fill "rgb(255,255,255)" -opaque "rgb(0,0,0)" "$2"
}
#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }
##################################################
#        Cp with progress bar (using pv)		 #
##################################################
function cp_p() {
	if [ `echo "$2" | grep ".*\/$"` ]
	then
		pv "$1" > "$2""$1"
	else
		pv "$1" > "$2"/"$1"
	fi
}
##################################################
#            CIA world fact book				 #
##################################################
function fact() {
    dict -d world02 $@
}
##################################################
#   Recursively fix dir/file permissions on a	 #
#            given directory				     #
##################################################
function fix() {
if [ -d $1 ]; then
find $1 -type d -exec chmod 755 {} \;
find $1 -type f -exec chmod 644 {} \;
else
echo "$1 is not a directory."
fi
}
##################################################
#     Colored word-by-word diff of two files	 #
##################################################
###### ex.: showdiff oldversion.txt newversion.txt
function showdiff()
{
wdiff -n -w $'\033[30;41m' -x $'\033[0m' -y $'\033[30;42m' -z $'\033[0m' $1 $2
}
##################################################
#     Move all files in current directory 		 #
#           (recursively) up a level			 #
##################################################
function upalevel()
{
find . -type f | perl -pe '(s!(\./.*/)(.*)!mv "\1\2" "\1../\2"!);' | sh
}

