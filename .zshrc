# define environmental variable
export TERM=xterm-256color
export SPARK_HOME=/opt/spark
export PATH=${SPARK_HOME}/bin:$PATH
export PYTHONIOENCODING=utf-8

# enable color
autoload -Uz colors && colors

# bind like emacs
bindkey -e

# history config
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# PROMPT 2 Line display
setopt prompt_subst
PROMPT="%{${fg[cyan]}%}[%n@%m]%{${reset_color}%} %~
 >> "

autoload -U promptinit && promptinit

# define delimiter
autoload -Uz select-word-style
select-word-style default
# specify chars as delimiter
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# completion settings
# enable completion
autoload -Uz compinit && compinit

# ignore case in completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# not complete after ../
zstyle ':completion:*' ignore-parents parent pwd ..

# complete after sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                       /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# complete after ps command
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

zstyle ':completion:*' menu select interactive
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
# option
# display japanese name
setopt print_eight_bit

# disable beep
setopt no_beep

# disable flow control
setopt no_flow_control

# comment out after '#'
setopt interactive_comments

# enable cd only directory name
setopt auto_cd

# pushd after cd
setopt auto_pushd

# ignore pushd if dupulicated
setopt pushd_ignore_dups

# complete after =
setopt magic_equal_subst

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

# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu

# 高機能なワイルドカード展開を使用する
#setopt extended_glob

########################################
# key bind
# enable wildcard with * when ^R
bindkey '^R' history-incremental-pattern-search-backward

########################################
# alias

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# enable alias after sudo
alias sudo='sudo '

# global alias
alias -g L='| less'
alias -g G='| grep'

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

