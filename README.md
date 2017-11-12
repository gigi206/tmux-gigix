tmux-gigix
==========

- [tmux-gigix](#tmux-gigix)
  * [Presentation](#presentation)
  * [Requirements](#requirements)
  * [tmux.conf](#tmuxconf)
- [Putty support](#putty-support)
- [ZSH](#zsh)
- [Key mapping](#key-mapping)

Presentation
------------
Configuration file for tmux integration with [vim-gigix](https://github.com/gigi206/vim-gigix/)

![demo](screenshots/demo.png)

Requirements
-----------
* Install tmux 2.5+
* Install [powerline fonts](https://github.com/powerline/fonts)
* Install [vim-gigix](https://github.com/gigi206/vim-gigix/) (optionnal)
* install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (recommended)
  * Install plugins [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) and [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) (optionnal)
* install xclip (optionnal)

tmux.conf
---------
Put __*tmux.conf*__ in **~/.tmux.conf** or **/etc/tmux.conf**.

```
####################
#                  #
#     KEYBOARD     #
#                  #
####################

#Remapping Ctrl+b vers Ctrl+x
set -g prefix2 C-x
#set -g prefix2 C-a
#bind C-a send-prefix
#unbind C-b

#Alt+fléches gauche/droite pour bouger entre les fenêtres
bind-key -n M-Right next-window
bind-key -n M-Left previous-window

#Shift+fléches gauche/droite/haut/bas pour bouger entre les split
#bind-key -n C-M-Left select-pane -L
#bind-key -n C-M-Right select-pane -R
#bind-key -n C-M-Up select-pane -U
#bind-key -n C-M-Down select-pane -D

#Split vertical/horizontal
bind-key v split-window -h
bind-key h split-window -v

#Nouvelle fenêtre
#bind-key w new-window

#Kill window
bind-key k kill-window

#Gestion terminal
set-window-option -g xterm-keys on
#set -g default-terminal "putty-256color"
#set -g default-terminal "screen-256color"
set -g default-terminal "tmux-256color"

set -g terminal-overrides "putty*:kLFT5=\eOD:kRIT5=\eOC:kUP5=\eOA:kDN5=\eOB:smkx@:rmkx@"
#set -g terminal-overrides "putty*:kLFT@:kRIT@:kLFT5=\e[D:kRIT5=\e[C:kUP5=\e[A:kDN5=\e[B"

#Agrandir/retrecir le pane
bind-key -n C-Space resize-pane -Z

#Sélectionne le texte
bind-key -T copy-mode-vi v send-keys -X begin-selection

#Copie le texte sélectionné dans le buffer et qui le mode copy
bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

#Change le mode ligne vers le mode rectangle et vice-versa
bind-key -T copy-mode-vi r send-keys -X rectangle-toggle

#Sauvegarde le buffer dans le fichier choisi
bind-key C-f command-prompt -p "Save to file" "save-buffer \"%%%\""

#Sauvegarde le buffer dans ~/.tmux_save-buffer/<session_name>
bind-key C-s run-shell "tmux save-buffer ~/.tmux_save-buffer/#S && tmux display-message 'Copied tmux buffer to ~/.tmux_save-buffer/#S'"

#Copie le buffer dans le presse-papier
bind-key C-x run-shell "tmux show-buffer | xclip -sel clip -i && tmux display-message 'Copied tmux buffer to system clipboard'"


###########################
#                         #
#     Config générale     #
#                         #
###########################

#Gestion souris
set -g mouse on

#Bip
set -g bell-action none

#Mise à jour de la barre de status status
set -g status-interval 15

setw -g monitor-activity on
#setw -g window-status-activity-bg red
#setw -g window-status-activity-fg yellow
#set-option -gw window-status-activity-attr bold
#setw monitor-silence 30
#set-option -agw window-status-activity-style fg=white,bg=red,blink
#set-option -gw window-status-activity-style fg=red,bg=black,bold
#set -g visual-activity on

#Recharger la config
bind-key r source-file ~/.tmux.conf \; display-message "Configuration reloaded"

#History size
set -g history-limit 20000

#Temps pour éviter de renvoyer le send-prefix entre chaque comande
set -g repeat-time 1000

#Mode vi
set-window-option -g mode-keys vi


#################
#               #
#     THEME     #
#               #
#################

#Position de la statusbar
set -g status-position bottom

#Définition des couleurs du thème
set -g status-fg colour255
set -g status-bg colour23

#Messages
set -g message-fg default
set -g message-fg colour255
set -g message-bg default
set -g message-bg colour54
set -g message-attr default
set -g message-attr bold

#Command message
set -g message-command-bg colour54
set -g message-command-fg colour255

#Pane border
set -g pane-border-bg default
set -g pane-border-fg colour23

#Active pane border
set -g pane-active-border-bg default
set -g pane-active-border-fg colour36

#Pane number indicator
set -g display-panes-colour colour23
set -g display-panes-active-colour colour36

#Status bar
set -g window-status-separator ''
set-option -gw window-status-activity-style none

#set -g status-left-bg colour255
#set -g status-left-fg colour29
set -g status-left-length 40
set -g status-right-length 100


#set -g status-right-bg colour255
#set -g status-right-fg colour23
#set -g window-status-current-bg colour25
#set -g window-status-current-fg colour29

#set -g status-left "#[fg=colour255,bg=colour36]#[bold] Session #S # "
#set -g window-status-format "#[bg=colour23] #[fg=colour255,bg=colour29] #I#F / #W "
#set -g status-right "#(uptime | cut -d "," -f 2-) #[fg=colour255,bg=colour36] %H:%M #[fg=colour255,bg=colour29,bold] #{session_attached} #[fg=colour255,bg=colour36,bold] #(whoami)@#h "
#set -g window-status-current-format " #[fg=colour255,bg=colour202] #I#F / #W #[fg=colour202,bg=colour23]"

set -g status-left "#[fg=colour255,bg=colour36]#[bold] Session #S #[fg=colour36,bg=colour23]"
set -g status-right " #(uptime | cut -d "," -f 3-) #[fg=colour36,bg=colour23]#[fg=colour255,bg=colour36] %H:%M #[fg=colour29,bg=colour36]#[fg=colour255,bg=colour29 bold] #{session_attached} #[fg=colour36,bg=colour29]#[fg=colour255,bg=colour36] #[fg=colour255,bg=colour36,bold]#h "
set -g window-status-format "#[fg=colour23,bg=colour29]#{?window_activity_flag,#[bg=colour255 fg=colour23],#[bg=colour29 fg=colour23]}#[fg=colour255,bg=colour29]#{?window_activity_flag,#[bg=colour255 fg=colour28],#[bg=colour29 fg=colour255]} #I#F  #W #[fg=colour29,bg=colour23]#{?window_activity_flag,#[bg=colour23 fg=colour255],#[bg=colour23 fg=colour29]}"
set -g window-status-current-format "#[fg=colour23,bg=colour202]#[fg=colour255,bg=colour202] #I#F / #W #[fg=colour202,bg=colour23]"

#if-shell 'xhost' '\
#    set -g status-left "#[fg=colour255,bg=colour36]#[bold] Session #S #[fg=colour36,bg=colour23]";\
#    set -g status-right " #(uptime | cut -d "," -f 2-) #[fg=colour36,bg=colour23]#[fg=colour255,bg=colour36] %H:%M #[fg=colour29,bg=colour36]#[fg=colour255,bg=colour29 bold] #{session_attached} #[fg=colour36,bg=colour29]#[fg=colour255,bg=colour36] #[fg=colour255,bg=colour36,bold]#h ";\
#    set -g window-status-format "#[fg=colour23,bg=colour29]#{?window_activity_flag,#[bg=colour255 fg=colour23],#[bg=colour29 fg=colour23]}#[fg=colour255,bg=colour29]#{?window_activity_flag,#[bg=colour255 fg=colour28],#[bg=colour29 fg=colour255]} #I#F  #W #[fg=colour29,bg=colour23]#{?window_activity_flag,#[bg=colour23 fg=colour255],#[bg=colour23 fg=colour29]}";\
#    set -g window-status-current-format "#[fg=colour23,bg=colour202]#[fg=colour255,bg=colour202] #I#F / #W #[fg=colour202,bg=colour23]"'
#
#if-shell '! xhost' '\
#    set -g status-left "#[fg=colour255,bg=colour36]#[bold] Session #S # ";\
#    set -g window-status-format "#[bg=colour23] #[fg=colour255,bg=colour29] #I#F / #W ";\
#    set -g status-right "#(uptime | cut -d "," -f 2-) #[fg=colour255,bg=colour36] %H:%M #[fg=colour255,bg=colour29,bold] #{session_attached} #[fg=colour255,bg=colour36,bold] #(whoami)@#h ";\
#    set -g window-status-current-format " #[fg=colour255,bg=colour202] #I#F / #W #[fg=colour202,bg=colour23]"'

#Paramètres user
if '[ -f ~/.tmux.conf.local ]' 'source ~/.tmux.conf.local'
```

Putty support
=============
If you use putty you need to install this reg file :
```ini
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\Linux]
"Present"=dword:00000001
"HostName"=""
"LogFileName"="putty.log"
"LogType"=dword:00000000
"LogFileClash"=dword:ffffffff
"LogFlush"=dword:00000001
"SSHLogOmitPasswords"=dword:00000001
"SSHLogOmitData"=dword:00000000
"Protocol"="ssh"
"PortNumber"=dword:00000016
"CloseOnExit"=dword:00000001
"WarnOnClose"=dword:00000001
"PingInterval"=dword:00000000
"PingIntervalSecs"=dword:00000000
"TCPNoDelay"=dword:00000001
"TCPKeepalives"=dword:00000000
"TerminalType"="putty-256color"
"TerminalSpeed"="38400,38400"
"TerminalModes"="CS7=A,CS8=A,DISCARD=A,DSUSP=A,ECHO=A,ECHOCTL=A,ECHOE=A,ECHOK=A,ECHOKE=A,ECHONL=A,EOF=A,EOL=A,EOL2=A,ERASE=A,FLUSH=A,ICANON=A,ICRNL=A,IEXTEN=A,IGNCR=A,IGNPAR=A,IMAXBEL=A,INLCR=A,INPCK=A,INTR=A,ISIG=A,ISTRIP=A,IUCLC=A,IUTF8=A,IXANY=A,IXOFF=A,IXON=A,KILL=A,LNEXT=A,NOFLSH=A,OCRNL=A,OLCUC=A,ONLCR=A,ONLRET=A,ONOCR=A,OPOST=A,PARENB=A,PARMRK=A,PARODD=A,PENDIN=A,QUIT=A,REPRINT=A,START=A,STATUS=A,STOP=A,SUSP=A,SWTCH=A,TOSTOP=A,WERASE=A,XCASE=A"
"AddressFamily"=dword:00000000
"ProxyExcludeList"=""
"ProxyDNS"=dword:00000001
"ProxyLocalhost"=dword:00000000
"ProxyMethod"=dword:00000000
"ProxyHost"="proxy"
"ProxyPort"=dword:00000050
"ProxyUsername"=""
"ProxyPassword"=""
"ProxyTelnetCommand"="connect %host %port\\n"
"Environment"=""
"UserName"=""
"LocalUserName"=""
"NoPTY"=dword:00000000
"Compression"=dword:00000000
"TryAgent"=dword:00000001
"AgentFwd"=dword:00000000
"ChangeUsername"=dword:00000000
"Cipher"="aes,chacha20,blowfish,3des,WARN,arcfour,des"
"KEX"="ecdh,dh-gex-sha1,dh-group14-sha1,dh-group1-sha1,rsa,WARN"
"RekeyTime"=dword:0000003c
"RekeyBytes"="1G"
"SshNoAuth"=dword:00000000
"AuthTIS"=dword:00000000
"AuthKI"=dword:00000001
"SshNoShell"=dword:00000000
"SshProt"=dword:00000003
"SSH2DES"=dword:00000000
"PublicKeyFile"=""
"RemoteCommand"="tmux attach -t GigiX || tmux new -s GigiX"
"RFCEnviron"=dword:00000000
"PassiveTelnet"=dword:00000000
"BackspaceIsDelete"=dword:00000001
"RXVTHomeEnd"=dword:00000000
"LinuxFunctionKeys"=dword:00000000
"NoApplicationKeys"=dword:00000001
"NoApplicationCursors"=dword:00000000
"NoMouseReporting"=dword:00000000
"NoRemoteResize"=dword:00000000
"NoAltScreen"=dword:00000000
"NoRemoteWinTitle"=dword:00000000
"RemoteQTitleAction"=dword:00000001
"NoDBackspace"=dword:00000000
"NoRemoteCharset"=dword:00000000
"ApplicationCursorKeys"=dword:00000000
"ApplicationKeypad"=dword:00000000
"NetHackKeypad"=dword:00000000
"AltF4"=dword:00000001
"AltSpace"=dword:00000000
"AltOnly"=dword:00000000
"ComposeKey"=dword:00000000
"CtrlAltKeys"=dword:00000001
"TelnetKey"=dword:00000000
"TelnetRet"=dword:00000001
"LocalEcho"=dword:00000002
"LocalEdit"=dword:00000002
"Answerback"="PuTTY"
"AlwaysOnTop"=dword:00000000
"FullScreenOnAltEnter"=dword:00000001
"HideMousePtr"=dword:00000000
"SunkenEdge"=dword:00000000
"WindowBorder"=dword:00000001
"CurType"=dword:00000000
"BlinkCur"=dword:00000000
"Beep"=dword:00000000
"BeepInd"=dword:00000000
"BellWaveFile"=""
"BellOverload"=dword:00000001
"BellOverloadN"=dword:00000005
"BellOverloadT"=dword:000007d0
"BellOverloadS"=dword:00001388
"ScrollbackLines"=dword:00030d40
"DECOriginMode"=dword:00000000
"AutoWrapMode"=dword:00000001
"LFImpliesCR"=dword:00000000
"DisableArabicShaping"=dword:00000000
"DisableBidi"=dword:00000000
"WinNameAlways"=dword:00000001
"WinTitle"=""
"TermWidth"=dword:00000050
"TermHeight"=dword:00000018
"Font"="DejaVu Sans Mono for Powerline"
"FontIsBold"=dword:00000000
"FontCharSet"=dword:00000000
"FontHeight"=dword:0000000a
"FontQuality"=dword:00000003
"FontVTMode"=dword:00000004
"UseSystemColours"=dword:00000000
"TryPalette"=dword:00000000
"ANSIColour"=dword:00000001
"Xterm256Colour"=dword:00000001
"BoldAsColour"=dword:00000001
"Colour0"="187,187,187"
"Colour1"="255,255,255"
"Colour2"="0,43,54"
"Colour3"="85,85,85"
"Colour4"="0,0,0"
"Colour5"="0,255,0"
"Colour6"="0,0,0"
"Colour7"="85,85,85"
"Colour8"="187,0,0"
"Colour9"="255,85,85"
"Colour10"="0,187,0"
"Colour11"="85,255,85"
"Colour12"="187,187,0"
"Colour13"="255,255,85"
"Colour14"="0,0,187"
"Colour15"="85,85,255"
"Colour16"="187,0,187"
"Colour17"="255,85,255"
"Colour18"="0,187,187"
"Colour19"="85,255,255"
"Colour20"="187,187,187"
"Colour21"="255,255,255"
"RawCNP"=dword:00000000
"PasteRTF"=dword:00000001
"MouseIsXterm"=dword:00000000
"RectSelect"=dword:00000000
"MouseOverride"=dword:00000001
"Wordness0"="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
"Wordness32"="0,1,2,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1"
"Wordness64"="1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,2"
"Wordness96"="1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1"
"Wordness128"="1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1"
"Wordness160"="1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1"
"Wordness192"="2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,2,2,2,2,2,2,2,2"
"Wordness224"="2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,2,2,2,2,2,2,2,2"
"LineCodePage"="UTF-8"
"CJKAmbigWide"=dword:00000000
"UTF8Override"=dword:00000001
"Printer"=""
"CapsLockCyr"=dword:00000000
"ScrollBar"=dword:00000001
"ScrollBarFullScreen"=dword:00000000
"ScrollOnKey"=dword:00000000
"ScrollOnDisp"=dword:00000001
"EraseToScrollback"=dword:00000001
"LockSize"=dword:00000000
"BCE"=dword:00000001
"BlinkText"=dword:00000000
"X11Forward"=dword:00000000
"X11Display"=""
"X11AuthType"=dword:00000001
"LocalPortAcceptAll"=dword:00000000
"RemotePortAcceptAll"=dword:00000000
"PortForwardings"=""
"BugIgnore1"=dword:00000000
"BugPlainPW1"=dword:00000000
"BugRSA1"=dword:00000000
"BugHMAC2"=dword:00000000
"BugDeriveKey2"=dword:00000000
"BugRSAPad2"=dword:00000000
"BugPKSessID2"=dword:00000000
"BugRekey2"=dword:00000000
"StampUtmp"=dword:00000001
"LoginShell"=dword:00000001
"ScrollbarOnLeft"=dword:00000000
"BoldFont"=""
"BoldFontIsBold"=dword:0000007f
"BoldFontCharSet"=dword:01e81e08
"BoldFontHeight"=dword:01e81e08
"WideFont"=""
"WideFontIsBold"=dword:773beb7e
"WideFontCharSet"=dword:0000007f
"WideFontHeight"=dword:00000000
"WideBoldFont"=""
"WideBoldFontIsBold"=dword:fffffffe
"WideBoldFontCharSet"=dword:773beb7e
"WideBoldFontHeight"=dword:0018fc18
"ShadowBold"=dword:00000000
"ShadowBoldOffset"=dword:00000001
"SerialLine"="COM1"
"SerialSpeed"=dword:00002580
"SerialDataBits"=dword:00000008
"SerialStopHalfbits"=dword:00000002
"SerialParity"=dword:00000000
"SerialFlowControl"=dword:00000001
"ProxyLogToTerm"=dword:00000001
"UserNameFromEnvironment"=dword:00000000
"GssapiFwd"=dword:00000000
"HostKey"="ed25519,ecdsa,rsa,dsa,WARN"
"SshBanner"=dword:00000001
"AuthGSSAPI"=dword:00000001
"GSSLibs"="gssapi32,sspi,custom"
"GSSCustom"=""
"LogHost"=""
"NoRemoteClearScroll"=dword:00000000
"CRImpliesLF"=dword:00000000
"X11AuthFile"=""
"BugIgnore2"=dword:00000000
"BugMaxPkt2"=dword:00000000
"BugOldGex2"=dword:00000000
"BugWinadj"=dword:00000000
"BugChanReq"=dword:00000000
"WindowClass"=""
"ConnectionSharing"=dword:00000000
"ConnectionSharingUpstream"=dword:00000001
"ConnectionSharingDownstream"=dword:00000001
"SSHManualHostKeys"=""
```

ZSH
===
If you have installed [oh-my-zsh](http://ohmyz.sh/) .

### .zshrc

Edit your _**~./zshrc**_ and modify like below :
```zsh
plugins=([...] zsh-syntax-highlighting zsh-autosuggestions)
# https://github.com/zsh-users/zsh-autosuggestions => $ZSH_CUSTOM/plugins
# https://github.com/zsh-users/zsh-syntax-highlighting => $ZSH_CUSTOM/plugins

#GigiX
PROMPT='%{$fg[green]%}%n%{$fg[white]%}@%{$fg[magenta]%}%m%{$fg[white]%}:%{$fg[cyan]%}%~%{$reset_color%} ${ret_status}$(git_prompt_info)%{$reset_color%}'
```
Move plugins [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) and [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) in **_$ZSH_CUSTOM/plugins_**.

### custom scripts

Rebind some keys and force tab to 4 spaces (for compatibility with [vim-gigix](https://github.com/gigi206/vim-gigix/)) :
```zsh
#Cause des problèmes avec git
unsetopt extendedglob

#Problème avec les "-" dans les nom de variables
setopt norecexact

#Ctrl+w => supprime le dernier mot
autoload -U select-word-style
select-word-style bash
bindkey '^W' backward-kill-word
autoload -U backward-kill-word-match
zle -N backward-kill-word backward-kill-word-match
zstyle ':zle:backward-kill-word' word-style whitespace-subword

#Gestion tab au milieu d'un ligne (grace à _prefix)
zstyle ':completion:*' completer _complete _prefix:-complete _prefix:-approximate

#Alt+w => supprime le denier groupe reconnu comme mots
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
ZSH_HIGHLIGHT_STYLES[globbing]='fg=208,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=200,bold'
ZSH_HIGHLIGHT_STYLES[assign]='fg=62'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=97'

#Alias
alias lsblk='lsblk --output NAME,KNAME,FSTYPE,SIZE,TYPE,MOUNTPOINT,REV,VENDOR,MAJ:MIN,LABEL,PARTLABEL,RO,RM,STATE,RQ-SIZE,MIN-IO'
alias history='fc -li -100000 | grep $(date -I)'
alias h=history

#Less
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
#export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'•
export LESS_TERMCAP_ue=$'\E[0m'
export GROFF_NO_SGR=1

#Force la tab à 4 espaces
tabs -4
```

Key mapping
===========
Default prefix haven't changed `C-b`
I put a second prefix `C-x`

All default prefix have been kept.

For see all key mapping press`<prefix> ?`

| Command             | Alias     | Keystrokes                                                                                                                                                                                           | Description                                                 |
|---------------------|-----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| attach-session      | attach    |                                                                                                                                                                                                      | attach or switch to a session                               |
| bind-key            | bind      |                                                                                                                                                                                                      | bind a key to a command                                     |
| break-pane          | breakp    | `<prefix>!`                                                                                                                                                                                          | break a pane from an existing into a new window             |
| capture-pane        | capturep  |                                                                                                                                                                                                      | capture the contents of a pane to a buffer                  |
| choose-buffer       |           | `<prefix>=`                                                                                                                                                                                          | put a window into buffer choice mode                        |
| choose-client       |           | `<prefix>D`                                                                                                                                                                                          | put a window into client choice mode                        |
| choose-session      |           |                                                                                                                                                                                                      | put a window into session choice mode                       |
| choose-tree         |           | `<prefix>s`                                                                                                                                                                                          | put a window into tree choice mode                          |
| choose-window       |           | `<prefix>w`                                                                                                                                                                                          | put a window into window choice mode                        |
| clear-history       | clearhist |                                                                                                                                                                                                      | remove and clear history for a pane                         |
| clock-mode          |           | `<prefix>t`                                                                                                                                                                                          | enter clock mode                                            |
| command-prompt      |           | `<prefix>:`                                                                                                                                                                                          | open the tmux command prompt in a client                    |
| confirm-before      | confirm   |                                                                                                                                                                                                      | run a command but ask for confirmation before               |
| copy-mode           |           | `<prefix>[`                                                                                                                                                                                          | enter copy mode                                             |
| delete-buffer       | deleteb   | `<prefix>-`                                                                                                                                                                                          | delete a paste buffer                                       |
| detach-client       | detach    | `<prefix>d`                                                                                                                                                                                          | detach a client from the server                             |
| display-message     | display   | `<prefix>i`                                                                                                                                                                                          | display a message in the status line                        |
| display-panes       | displayp  | `<prefix>q`                                                                                                                                                                                          | display an indicator for each visible pane                  |
| find-window         | findw     | `<prefix>f`                                                                                                                                                                                          | search for a pattern in windows                             |
| has-session         | has       |                                                                                                                                                                                                      | check and report if a session exists on the server          |
| if-shell            | if        |                                                                                                                                                                                                      | execute a tmux command if a shell-command succeeded         |
| join-pane           | joinp     |                                                                                                                                                                                                      | split a pane and move an existing one into the new space    |
| kill-pane           | killp     | `<prefix>x`                                                                                                                                                                                          | destroy a given pane                                        |
| kill-server         |           |                                                                                                                                                                                                      | kill clients, sessions and server                           |
| kill-session        |           |                                                                                                                                                                                                      | destroy a given session                                     |
| kill-window         | killw     | `<prefix>&` `<prefix>k`                                                                                                                                                                              | destroy a given window                                      |
| last-pane           | lastp     | `<prefix>;`                                                                                                                                                                                          | select the previously selected pane                         |
| last-window         | last      | `<prefix>l`                                                                                                                                                                                          | select the previously selected window                       |
| link-window         | linkw     |                                                                                                                                                                                                      | link a window to another                                    |
| list-buffers        | lsb       | `<prefix>#`                                                                                                                                                                                          | list paste buffers of a session                             |
| list-clients        | lsc       |                                                                                                                                                                                                      | list clients attached to server                             |
| list-commands       | lscm      |                                                                                                                                                                                                      | list supported sub-commands                                 |
| list-keys           | lsk       | `<prefix>?`                                                                                                                                                                                          | list all key-bindings                                       |
| list-panes          | lsp       |                                                                                                                                                                                                      | list panes of a window                                      |
| list-sessions       | ls        |                                                                                                                                                                                                      | list sessions managed by server                             |
| list-windows        | lsw       |                                                                                                                                                                                                      | list windows of a session                                   |
| load-buffer         | loadb     |                                                                                                                                                                                                      | load a file into a paste buffer                             |
| lock-client         | lockc     |                                                                                                                                                                                                      | lock a client                                               |
| lock-server         | lock      |                                                                                                                                                                                                      | lock all clients attached to the server                     |
| lock-session        | locks     |                                                                                                                                                                                                      | lock all clients attached to a session                      |
| move-pane           | movep     |                                                                                                                                                                                                      | move a pane into a new space                                |
| move-window         | movew     | `<prefix>.`                                                                                                                                                                                          | move a window to another                                    |
| new-session         | new       |                                                                                                                                                                                                      | create a new session                                        |
| new-window          | neww      | `<prefix>c`                                                                                                                                                                                          | create a new window                                         |
| next-layout         | nextl     | `<prefix><space>`                                                                                                                                                                                    | move a window to the next layout                            |
| next-window         | next      | `<prefix>n` `<prefix><Meta>+n` `<Meta>+Right`                                                                                                                                                        | move to the next window in a session                        |
| paste-buffer        | pasteb    | `<prefix>]`                                                                                                                                                                                          | insert a paste buffer into the window                       |
| pipe-pane           | pipep     |                                                                                                                                                                                                      | pipe output from a pane to a shell command                  |
| previous-layout     | prevl     |                                                                                                                                                                                                      | move a window to the previous layout                        |
| previous-window     | prev      | `<prefix>p` `<prefix><Meta>+p` `<Meta>+Left`                                                                                                                                                         | move to the previous window in a session                    |
| refresh-client      | refresh   |                                                                                                                                                                                                      | refresh a client                                            |
| rename-session      | rename    | `<prefix>$`                                                                                                                                                                                          | rename a session                                            |
| rename-window       | renamew   | `<prefix>,`                                                                                                                                                                                          | rename a window                                             |
| resize-pane         | resizep   | `<prefix>z` `<prefix><Meta>+Up` `<prefix><Meta>+Down` `<prefix><Meta>+Left` `<prefix><Meta>+Right` `<Ctrl>+z` `<prefix><Ctrl>+Up` `<prefix><Ctrl>+Down` `<prefix><Ctrl>+Left` `<prefix><Ctrl>+Right` | resize a pane                                               |
| respawn-pane        | respawnp  |                                                                                                                                                                                                      | reuse a pane in which a command has exited                  |
| respawn-window      | respawnw  |                                                                                                                                                                                                      | reuse a window in which a command has exited                |
| rotate-window       | rotatew   | `<prefix><Ctrl+o>` `<prefix><Meta>+o`                                                                                                                                                                | rotate positions of panes in a window                       |
| run-shell           | run       |                                                                                                                                                                                                      | execute a command without creating a new window             |
| save-buffer         | saveb     | `<prefix><Ctrl>+f` `<prefix><Ctrl>+s` `<prefix><Ctrl>+x`                                                                                                                                             | save a paste buffer to a file                               |
| select-layout       | selectl   | `<prefix><Meta>+1` `<prefix><Meta>+2` `<prefix><Meta>+3` `<prefix><Meta>+4` `<prefix><Meta>+5`                                                                                                       | choose a layout for a window                                |
| select-pane         | selectp   |                                                                                                                                                                                                      | make a pane the active one in the window                    |
| select-window       | selectw   | `<prefix>'` `<prefix>0` `<prefix>1` `<prefix>2` `<prefix>3` `<prefix>4` `<prefix>5` `<prefix>6` `<prefix>7` `<prefix>8` `<prefix>9`                                                                  | select a window                                             |
| send-keys           | send      |                                                                                                                                                                                                      | send key(s) to a window                                     |
| send-prefix         |           | `<Crtl>b` `<Ctrl>x`                                                                                                                                                                                  | send the prefix key to a window                             |
| server-info         | info      |                                                                                                                                                                                                      | show server information                                     |
| set-buffer          | setb      |                                                                                                                                                                                                      | set contents of a paster buffer                             |
| set-environment     | setenv    |                                                                                                                                                                                                      | (un)set an environment variable                             |
| set-hook            |           |                                                                                                                                                                                                      | --set a hook to a command                                   |
| set-option          | set       |                                                                                                                                                                                                      | set a session option                                        |
| set-window-option   | setw      |                                                                                                                                                                                                      | set a window option                                         |
| show-buffer         | showb     |                                                                                                                                                                                                      | display the contents of a paste buffer                      |
| show-environment    | showenv   |                                                                                                                                                                                                      | display the environment                                     |
| show-hooks          |           |                                                                                                                                                                                                      | show the global list of hooks                               |
| show-messages       | showmsgs  | `<prefix>~`                                                                                                                                                                                          | show client's message log                                   |
| show-options        | show      |                                                                                                                                                                                                      | show session options                                        |
| show-window-options | showw     |                                                                                                                                                                                                      | show window options                                         |
| source-file         | source    | `<prefix>r`                                                                                                                                                                                          | execute tmux commands from a file                           |
| split-window        | splitw    | `<prefix>"` `<prefix>%` `<prefix>h` `<prefix>v`                                                                                                                                                      | splits a pane into two                                      |
| start-server        | start     |                                                                                                                                                                                                      | start a tmux server                                         |
| suspend-client      | suspendc  | `<prefix><Ctrl>z`                                                                                                                                                                                    | suspend a client                                            |
| swap-pane           | swapp     | `<prefix>{` `<prefix>}`                                                                                                                                                                             | swap two panes                                              |
| swap-window         | swapw     |                                                                                                                                                                                                      | swap two windows                                            |
| switch-client       | switchc   | `<prefix>(` `<prefix>)` `<prefix>L`                                                                                                                                                                  | switch the client to another session                        |
| unbind-key          | unbind    |                                                                                                                                                                                                      | unbind a key                                                |
| unlink-window       | unlinkw   |                                                                                                                                                                                                      | unlink a window                                             |
| wait-for            | wait      |                                                                                                                                                                                                      | wait for an event or trigger it                             |
