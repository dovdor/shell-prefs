# Show history
alias history='fc -l 1'

# List direcory contents
alias lsa='ls -lah'
alias l='ls -la'
alias sl=ls # often screw this up
alias ll='ls -letr'

# always use original ftp
alias ftp='/usr/bin/ftp'

# app shortcuts
alias vi=mvim

# allows visual diff files. 
# --no-tabs for new window (allows -f)
# -d for diff mode
# -O for vertical split
# -f so command prompt will wait for diff to finish
alias vidif='vi --no-tabs -dfO'
alias p4v='open -a p4v'
alias p4opened='p4 opened $PWD/...'
alias p4update='p4 sync $PWD/...'
alias p4commit='p4 submit $PWD/...'
alias p4resolve='p4 resolve -as $PWD/...'
alias p4changes='p4 changes $PWD/... | head -n 10'

# undo some lib/aliases
unalias afind

alias inkscape=/Applications/Inkscape.app/Contents/MacOS/Inkscape
alias gimp=/Applications/GIMP.app/Contents/MacOS/Gimp
