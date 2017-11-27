##################################################
# Variable
#
# define environmental variable
set -x TERM xterm-256color

# XDG Base Directory Specification
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache

# nvim debug
set -x NVIM_PYTHON_LOG_FILE /tmp/log
set -x NVIM_PYTHON_LOG_LEVEL DEBUG

# java env
set -x JAVA_HOME (/usr/libexec/java_home)
# set -x CLASSPATH /usr/share/java/postgresql-jdbc4.jar $HOME/code_java/jdbc
set -x PATH /Applications/dsdriver/bin $PATH

# pyenv
set -x PYTHONIOENCODING utf-8
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH {$PYENV_ROOT}/bin $PATH
. (pyenv init - | psub)

# rbenv
set -x PATH $HOME/.rbenv/bin $PATH
set -x PATH $HOME/.rbenv/ $PATH

# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

# spark
# set -x SPARK_HOME /opt/spark
# set -x PATH {$SPARK_HOME}/bin $PATH

##################################################
# Alias
# function samplefunction -d "sample function for understand fish"
# 	command echo "hello world"
# 	command echo $argv
# end
# function fzf_z 
# 	set -l query (commandline)
# end
#
# (echo "hello" ; find .) | fzf --height 40% --reverse  --inline-info +s 


alias fd '__fzf_cd_with_hidden'
alias ff '__fzf_find_file'







##################################################
# Git

# show unstaged (*) and staged (+)
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate 'Dirty'
set __fish_git_prompt_char_stagedstate 'Staged'
set __fish_git_prompt_char_untrackedfiles 'Untracked'
set __fish_git_prompt_char_stashstate 'Stashed'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'

##################################################
# Prompt

# left prompt
function fish_prompt -d "Write out the prompt"
	if [ $status -eq 0 ]
		set status_face (set_color green)' ><((("> '(set_color normal)
	else
		set status_face (set_color red)' ><((("> '(set_color normal)
	end
	set prompt (set_color blue)\[(whoami)@(prompt_hostname)\] (set_color cyan)(prompt_pwd)
	echo $prompt
	echo $status_face
end

# right prompt
function fish_right_prompt --description 'Write out the right prompt'
	set -l git_dir (git rev-parse --git-dir 2> /dev/null)
	if test -n "$git_dir"
		echo (__fish_git_prompt)
	else
		echo
	end
end

# key bindings
# fish_vi_key_bindings
# function fish_user_key_bindings
# 	bind -M insert  jj cancel
# bind -M insert \cu kill-whole-line force-repaint
# bind -M insert \cf accept-autosuggestion
# end

##################################################
# Others

# erase "Welcome to fish, the friendly interactive shell"
set fish_greeting

# share history between ttys
function history-merge --on-event fish_preexec
	history --save
	history --merge
end


