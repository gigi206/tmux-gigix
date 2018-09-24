#Cause des problèmes avec git
unsetopt extendedglob

#Problème avec les "-" dans les noms de variables
setopt norecexact

#Pas de partage d'historique entre les sessions
setopt nosharehistory

WORDCHARS='*?_-+.[]~=&,;:§!#$£%^¨(){}<>/\@`°|"'"'"

#Ctrl+w => supprime le dernier mot
#autoload -U select-word-style
#select-word-style bash
#bindkey '^W' backward-kill-word
#autoload -U backward-kill-word-match
#zle -N backward-kill-word backward-kill-word-match
#zstyle ':zle:backward-kill-word' word-style whitespace-subword

#custom-backward-delete-word() {
#    local WORDCHARS='*?_-+.[]~=&,;:§!#$£%^¨(){}<>/\@`°|"'"'"
#    zle backward-delete-word
#}
#zle -N custom-backward-delete-word
#bindkey '^W' custom-backward-delete-word

#Alt+Backspace => surpprime jusqu'au prochain espace ou slash
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey "^[${terminfo[kbs]}" backward-kill-dir

#Gestion tab au milieu d'une ligne (grace à _prefix)
zstyle ':completion:*' completer _complete _prefix:-complete _prefix:-approximate

#Alt+w => supprime le denier groupe reconnu comme mot
bindkey "^[w" vi-backward-kill-word

#Fléches haut/bas => navigation dans l'historique
bindkey "$terminfo[kcuu1]" up-line-or-history
bindkey "$terminfo[kcud1]" down-line-or-history

#Ctrl+u => supprime du curseur jusqu'au début de la ligne
bindkey '^U' backward-kill-line

#Alt+u => supprime la ligne entière
bindkey "^[u" kill-whole-line

#Ctrl+fléches gauche/droite => mot précèdent/suivant
bindkey "${terminfo[kLFT5]}" backward-word
bindkey "${terminfo[kRIT5]}" forward-word

#Ctrl+fléches haut/bas => recherche dans l'historique ce qui commence par ce qui est entré
bindkey "${terminfo[kUP5]}" history-search-backward
bindkey "${terminfo[kDN5]}" history-search-forward

#Plugin zsh-syntax-highlighting => https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
#ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

#ZSH colors => http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Character-Highlighting
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[globbing]='fg=208,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=200,bold'
ZSH_HIGHLIGHT_STYLES[assign]='fg=62'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=97'

#Alias
alias lsblk='lsblk --output NAME,KNAME,FSTYPE,SIZE,TYPE,MOUNTPOINT,REV,VENDOR,MAJ:MIN,LABEL,PARTLABEL,RO,RM,STATE,RQ-SIZE,MIN-IO'
alias history='fc -li -100000'
alias h='fc -li -100000 | grep $(date -I)'

#Less
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
#export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'
export GROFF_NO_SGR=1

#Force la tab à 4 espaces
tabs -4
