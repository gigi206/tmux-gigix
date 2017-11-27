#Cause des problèmes avec git
unsetopt extendedglob

#Problème avec les "-" dans les noms de variables
setopt norecexact

#Ctrl+w => supprime le dernier mot
autoload -U select-word-style
select-word-style bash
bindkey '^W' backward-kill-word
autoload -U backward-kill-word-match
zle -N backward-kill-word backward-kill-word-match
zstyle ':zle:backward-kill-word' word-style whitespace-subword

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
        #Ctrl+fléches gauche/droite => mot précèdent/suivant
        bindkey '^[OD' backward-word
        bindkey '^[OC' forward-word

        #Ctrl+fléches haut/bas => recherche dans l'historique ce qui commence par ce qui est entré
        bindkey '^[OA' history-search-backward
        bindkey '^[OB' history-search-forward
   ;;

    xterm-256color|screen-256color)
        #Fléches gauches droites
        bindkey '^[[1;2D' backward-char
        bindkey '^[[1;2C' forward-char

        #Ctrl+fléches gauche/droite => mot précèdent/suivant
        bindkey '^[[1;5D' backward-word
        bindkey '^[[1;5C' forward-word
esac
