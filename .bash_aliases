##########  Aliases  ##########
alias ll='ls -CFGa'			    			# Preferred 'ls' implementation
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias rm='rm -iv'			    			# Preferred 'rm' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd: Makes new Dir and jumps inside
cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias ~="cd ~"                              # ~:            Go Home
alias showFiles='defaults write com.apple.finder AppleShowAllFiles -bool YES && killall Finder'										# show hidden files
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles -bool NO && killall Finder'										# hide (normally) hidden files

alias nanobu='nano -BC ~/.nano_backups'     #test2

##################################################
#                Permissions					 #
##################################################
	alias 000='chmod 000 -R'
	alias 640='chmod 640 -R'
	alias 644='chmod 644 -R'				# default permission for ('~/.dmrc' file)
	alias 755='chmod 755 -R'				# default permissions for $HOME (excluding '~/.dmrc' file)
	alias 775='chmod 775 -R'
	alias 777='chmod 777 -R'
	alias mx='chmod a+x'
	alias perm='stat --printf "%a %n \n "'	# requires a file name e.g. perm file
	alias permall='777'
	alias permhome='chmod 755 -R $HOME && chmod 644 $HOME/.dmrc'
	alias restoremod='chgrp users -R .;chmod u=rwX,g=rX,o=rX -R .;chown $(pwd |cut -d / -f 3) -R .'									# restore user,group and mod of an entire website
