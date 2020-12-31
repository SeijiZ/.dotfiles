########################################
# Environmental variable
export TERM=xterm-256color

case ${OSTYPE} in
  darwin*)
    export PATH=$PATH:$HOME/.dotfiles/bin
    # Java
    export JAVA_HOME=$(/usr/libexec/java_home)
    # DB2 Environmental variable
    [ -d /Applications/dsdriver ] && source /Applications/dsdriver/db2profile
    ;;
  linux*)
    ;;
esac

# XDG Base Directory Specification
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

# enable color
autoload -Uz colors && colors
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

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
setopt print_eight_bit             # display japanese name
setopt no_beep                     # disable beep
setopt no_flow_control             # disable flow control
setopt auto_cd                     # enable cd only directory name
setopt auto_pushd                  # pushd after cd
setopt pushd_ignore_dups           # ignore pushd if dupulicated
setopt share_history               # share history
setopt hist_ignore_all_dups        # ignore same command
setopt hist_save_no_dups           # Delete older duplicated command history
setopt hist_ignore_space           # Do not leave command in history that begin with space 
setopt hist_reduce_blanks          # Delete space when save history


