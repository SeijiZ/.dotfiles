########################################
# Environmental variable
export TERM=xterm-256color
export SPARK_HOME=/opt/spark
export PATH=${SPARK_HOME}/bin:$PATH

# java env
export JAVA_HOME=$(/usr/libexec/java_home)
#export CLASSPATH=/usr/share/java/postgresql-jdbc4.jar:$HOME/code_java/jdbc
export PATH=$PATH:/Applications/dsdriver/bin

# python env
export PYTHONIOENCODING=utf-8
export PYENV_ROOT="$HOME/.pyenv"
export PATH=${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:$PATH
eval "$(pyenv init -)"

# python nvim
export NVIM_PYTHON_LOG_FILE=/tmp/log
export NVIM_PYTHON_LOG_LEVEL=DEBUG

# XDG Base Directory Specification
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

# # nodebrew
# export PATH=$PATH:$HOME/.nodebrew/current/bin

# android sdk
export PATH=$PATH:$HOME/Library/Android/sdk/tools/bin

# enable command edit
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^Xe" edit-command-line
bindkey "^X^e" edit-command-line

# enable color
autoload -Uz colors && colors

# bind like emacs
bindkey -e

########################################
# Plugin
# source ~/.zplug/init.zsh
# zplug "b4b4r07/enhancd", use:init.sh
# ENHANCD_FILTER=fzf
# export ENHANCD_FILTER
#
#
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
setopt prompt_subst
PROMPT="%{${fg[cyan]}%}[%n@%m]%{${reset_color}%} %~
 %(?.%{${fg[green]}%}>> .%{${fg[red]}%}>> )%{${reset_color}%}"

autoload -U promptinit && promptinit
########################################
# vcs_info
# %a action
# %b branch
# %v the value of the first element of the psvar array parameter
# %F{color}...%f color between %F and %f
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
autoload -Uz is-at-least
#zstyle ':vcs_info:git:*' check-for-changes true
#zstyle ':vcs_info:git:*' stagedstr "{yellow}"
#zstyle ':vcs_info:git:*' unstagedstr "{red}"
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info*' formats '(%s)-[%b]'
zstyle ':vcs_info*' actionformats '(%s)-[%b]' '%m' '<!%a>'

function _update_vcs_info_msg(){
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]+="$vcs_info_msg_0_"
    [[ -n "$vcs_info_msg_1_" ]] && psvar[1]+="$vcs_info_msg_1_"
    [[ -n "$vcs_info_msg_2_" ]] && psvar[1]+="$vcs_info_msg_2_"
}

add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{cyan}%1v%f|)"

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
		BUFFER=$(history -n -r 1 | fzf --no-sort --reverse +m --query "$LBUFFER" --prompt="History > ")
		CURSOR=$#BUFFER
	}
	zle -N select-history-fzf
	bindkey '^r' select-history-fzf
else
	bindkey '^r' history-incremental-pattern-search-backward
fi

function git-branch-fzf()
{
	local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | perl -pne 's{^refs/heads/}{}' | fzf --query "$LBUFFER")
	if [ -n "$selected_branch" ]; then
		BUFFER="git checkout ${selected_branch}"
		zle accept-line
	fi

	zle reset-prompt
}
zle -N git-branch-fzf
bindkey '^b' git-branch-fzf

fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

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


### Added by the Bluemix CLI
source /usr/local/Bluemix/bx/zsh_autocomplete
