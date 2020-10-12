########################################
# Environmental variable
export TERM=xterm-256color

case ${OSTYPE} in
  darwin*)
    # java
    export JAVA_HOME=$(/usr/libexec/java_home)
    ;;
esac

# XDG Base Directory Specification
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

# enable command edit
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^Xe" edit-command-line
bindkey "^X^e" edit-command-line

# remove words like bash with ctrl u
bindkey \^U backward-kill-line

# enable color
autoload -Uz colors && colors

# bind like emacs
bindkey -e

########################################
# Plugin

if [ ! -d "$HOME/.zinit" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi
source ~/.zinit/bin/zinit.zsh
zinit light "b4b4r07/enhancd"
export ENHANCD_FILTER=fzf

########################################
# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end  history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


########################################
# Prompt

autoload -U promptinit && promptinit
########################################
# Main Prompt Escapes
# To view full info, 'man zshmisc'
#   %n: username
#   %m: hostname
#   %~: current directory
#   %v: the value of the first element of the psvar array parameter
#   %F{color}...%f: use different foreground color
#   %(x.true-text.false-text): Specifies a ternary expression
#
# In Addition to above, to view vcs_info 'man zshcontrib'
#   %s: VCS in use
#   %b: Current branch
#   %a: An identifier that describes the action. Only makes sense in actionformats.
#   %c: The string from the stagedstr
#   %u: The string from the unstagedstr
#

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
setopt prompt_subst
#
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "staged"
zstyle ':vcs_info:git:*' unstagedstr "unstaged"

# export following messages
#   $vcs_info_msg_0: normal message
#   $vcs_info_msg_1: warning message
#   $vcs_info_msg_2: error message
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' formats "%c%u(%s:%b)"
zstyle ':vcs_info:*' actionformats "%c%u(%s:%b|%a)"

function _update_vcs_info_msg(){
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "${vcs_info_msg_0_}" ]] && psvar[1]+="${vcs_info_msg_0_}"
    [[ -n "${vcs_info_msg_1_}" ]] && psvar[1]+="${vcs_info_msg_1_}"
    [[ -n "${vcs_info_msg_2_}" ]] && psvar[1]+="${vcs_info_msg_2_}"
}

add-zsh-hook precmd _update_vcs_info_msg

PROMPT="%F{cyan}[%n@%m]%f %~ %1(v|%F{green}%1v%f|)
%(?.%F{green}$%f .%F{red}$%f )"

########################################
# Delimiter
# define delimiter
autoload -Uz select-word-style
select-word-style default
# specify chars as delimiter
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# Completion
# enable completion
autoload -Uz compinit && compinit

# ignore case in completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# not complete after ../
zstyle ':completion:*' ignore-parents parent pwd ..

# complete after sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                       /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

zstyle ':completion:*:default' menu select=1
zmodload zsh/complist

# select complete-menu like vi
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

zstyle ':completion:*:processes' command 'ps x -o pid,s,args'      # complete after ps command
setopt auto_menu                   # enable completion when TAB repeatedly pushed
setopt auto_param_slash            # add end / when completion
setopt list_types                  # display file type
setopt auto_param_keys             # auto complete () etc
setopt interactive_comments        # comment out after '#'
setopt magic_equal_subst           # complete after =
setopt extended_glob               # 高機能なワイルドカード展開を使用する
setopt globdots                    # match files that starts with dot



########################################
# option
# display japanese name
setopt print_eight_bit

# disable beep
setopt no_beep

# disable flow control
setopt no_flow_control

# enable cd only directory name
setopt auto_cd

# pushd after cd
setopt auto_pushd

# ignore pushd if dupulicated
setopt pushd_ignore_dups

# share history
setopt share_history

# ignore same command
setopt hist_ignore_all_dups

# delete older duplicated command history
setopt hist_save_no_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks


########################################
# User Defined Function

# cd ghq managed git directory with fzf
function fzf-ghq() {
	local selected
	selected="$(ghq list --full-path | fzf --reverse --query="$LBUFFER")"
	if [ -n "$selected" ] ; then
		BUFFER="builtin cd $selected"
	fi
	builtin zle accept-line
}

zle -N fzf-ghq
bindkey '^]' fzf-ghq

# use history list with fzf
if which fzf >/dev/null 2>&1 ; then
	function select-history-fzf(){
    BUFFER="$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")"
		CURSOR=$#BUFFER
	}
	zle -N select-history-fzf
	bindkey '^r' select-history-fzf
else
	bindkey '^r' history-incremental-pattern-search-backward
fi

# ctrl o open / ctrl v nvr -cc vsplit
function open-file() {
    local out key file
    # out="$(find ./ -type f | fzf --bind 'ctrl-v:execute(nvr -cc vsplit $(echo {}))+accept' --bind 'ctrl-s:execute(nvr -cc split $(echo {}))+accept' --bind 'ctrl-o:execute(open $(echo {}))+accept' --no-sort +m --query "$LBUFFER" --prompt="File > " --expect=ctrl-v,ctrl-o,ctrl-s)"
    out="$(find ./ -type f | fzf --no-sort +m --query "$LBUFFER" --prompt="File > " --expect=ctrl-v,ctrl-o,ctrl-s)"
    key=$(head -1 <<< "$out")
    file=$(head -2 <<< "$out" | tail -1)
    if [ -n "$file" ]; then
        [ "$key" = "ctrl-o" ]  && open "$file"
        [ "$key" = "ctrl-v" ]  && nvr -cc vsplit "$file"
        [ "$key" = "ctrl-s" ]  && nvr -cc split "$file"
        BUFFER="$file"
    fi
}
zle -N open-file
bindkey '^o' open-file

########################################
# key bind
# enable wildcard with * when ^R

########################################
# alias

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias cl='clear'

alias mkdir='mkdir -p'

# enable alias after sudo
alias sudo='sudo '

# global alias
alias -g L='| less'
alias -g G='| grep'

# clear
alias cl=/usr/bin/clear

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi



########################################
# setting each os 
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        ;;
esac

# vim:set ft=zsh:


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
