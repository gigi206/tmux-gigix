#Cause des problèmes avec git
unsetopt extendedglob

#Problème avec les "-" dans les noms de variables
setopt norecexact

#Pas de partage d'historique entre les sessions
setopt nosharehistory

#Compatibilité bash
autoload -U bashcompinit && bashcompinit

#Définition mot zsh
WORDCHARS='*?_-+.[]~=&,;:§!#$£%^¨(){}<>\@`°|"'"'"

#Fonctions
custom-backward-kill-word () {
    local WORDCHARS="${WORDCHARS}/"
    zle backward-kill-word
}
zle -N custom-backward-kill-word

custom-backward-word () {
    local WORDCHARS="${WORDCHARS}/"
    zle backward-word
}
zle -N custom-backward-word

custom-forward-word () {
    local WORDCHARS="${WORDCHARS}/"
    zle forward-word
}
zle -N custom-forward-word

#Ctrl+w => surpprime jusqu'au prochain espace
bindkey '^W' custom-backward-kill-word

#Alt+Backspace => surpprime jusqu'au prochain espace ou slash
bindkey "^[${terminfo[kbs]}" backward-kill-word

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

case $TERM in
    putty-256color)
        #Ctrl+fléches gauche/droite => espace ou slash précèdent/suivant
        bindkey '^[OD' backward-word
        bindkey '^[OC' forward-word

        #Shift+fléches gauche/droite => espace précèdent/suivant
        #bindkey '^[OD' custom-backward-word
        #bindkey '^[OC' custom-forward-word

        #Ctrl+fléches haut/bas => recherche dans l'historique ce qui commence par ce qui est entré
        bindkey '^[OA' history-search-backward
        bindkey '^[OB' history-search-forward
   ;;

    xterm-256color | screen-256color | tmux-256color)
        #Ctrl+fléches gauche/droite => espace ou slash précèdent/suivant
        bindkey '^[[1;5D' backward-word
        bindkey '^[[1;5C' forward-word

        #Shift+fléches gauche/droite => espace précèdent/suivant
        bindkey '^[[1;2D' custom-backward-word
        bindkey '^[[1;2C' custom-forward-word

        #Ctrl+fléches haut/bas => recherche dans l'historique ce qui commence par ce qui est entré
        bindkey '^[[1;5A' history-search-backward
        bindkey '^[[1;5B' history-search-forward

        #Numpad + -  * / Enter
        if `xhost &>/dev/null`; then
            bindkey -s "^[Ok" "+"
            bindkey -s "^[Om" "-"
            bindkey -s "^[Oj" "*"
            bindkey -s "^[Oo" "/"
            bindkey -s "^[OM" "^M"
        fi
    ;;
esac
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
