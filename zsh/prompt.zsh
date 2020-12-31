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


