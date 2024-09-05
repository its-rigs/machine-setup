autoload colors -u && colors

# The variables are wrapped in \%\{\%\}. This should be the case for every
# variable that does not contain space.
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval $COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
  eval BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
  export $COLOR
  export BOLD_$COLOR
done

eval RESET='$reset_color'

export TERM=xterm-256color
export CLICOLOR=1
unset LS_COLOURS
export LSCOLORS="Gxfxcxdxbxegedabagacad"

