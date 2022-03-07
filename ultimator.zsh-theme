#
# Ultimator ZSH theme
#
# The basic structure is taken from the agnoster theme
# The git_super_status command needs zsh-git-prompt
# A slightly adapted version can be found here https://github.com/Ultimator14/zsh-git-prompt
#

# Arrow character from agnoster theme
SEGMENT_SEPARATOR=$'\ue0b0'

#
# Functions
#

function prompt_main_fg() {
    # Color definitions
    if [ $(id -u) -eq 0 ]; then
        # user is root
        local user_fg="%{$fg_bold[red]%}"
        local at_fg="%{$fg_bold[red]%}"
        local computer_fg="%{$fg_bold[red]%}"
    else
        local user_fg="%{$fg_bold[red]%}"
        local at_fg="%{$fg_bold[green]%}"
        local computer_fg="%{$fg_bold[blue]%}"
    fi

    # Main Prompt fg creation (user@computername)
    echo -n "${user_fg}%n${at_fg}@${computer_fg}%m "
}

function prompt_dir() {
    # Color definitions
    if [ $(id -u) -eq 0 ]; then
        # user is root
        local dir_fg="%{$fg_no_bold[black]%}"
        local dir_bg="%{$bg[red]%}"
        local dir_fg_inv="%{$fg_no_bold[red]%}"
        local dir_bg_inv="%{$bg[default]%}"
    else
        local dir_fg="%{$fg_no_bold[black]%}"
        local dir_bg="%{$bg[blue]%}"
        local dir_fg_inv="%{$fg_no_bold[blue]%}"
        local dir_bg_inv="%{$bg[default]%}"
    fi

    # Dir prompt creation
    echo -n "${dir_bg}${dir_fg}${SEGMENT_SEPARATOR}"
    echo -n "${dir_fg} %(5~|.../%3~|%~) ${dir_bg_inv}${dir_fg_inv}"
}

function prompt_ret_status() {
    local success_fg="%{$fg_bold[green]%}"
    local failure_fg="%{$fg_bold[red]%}"

    # Last command evaluation
    echo -n "%(?:${success_fg}$%{$reset_color%} :${failure_fg}$%{$reset_color%} )"
}

# Git color shortcuts
local git_fg="%{$fg_no_bold[black]%}"
local git_bg="%{$bg[yellow]%}"
local git_fg_inv="%{$fg_no_bold[yellow]%}"
local git_bg_inv="%{$bg[default]%}"

# Set git variables
ZSH_THEME_GIT_PROMPT_PREFIX="${git_bg}${SEGMENT_SEPARATOR} ${git_fg}\ue0a0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="${git_bg} ${git_bg_inv}${git_fg_inv}"

ZSH_THEME_GIT_PROMPT_DIRTY="${git_fg}${git_bg}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="${git_fg}${git_bg}✔"

ZSH_THEME_GIT_PROMPT_BRANCH="${git_fg}${git_bg}"
ZSH_THEME_GIT_PROMPT_SEPARATOR="${git_fg}${git_bg}|"
ZSH_THEME_GIT_PROMPT_UNTRACKED="${git_fg}${git_bg}…"
ZSH_THEME_GIT_PROMPT_CHANGED="${git_fg}${git_bg}⎊"
ZSH_THEME_GIT_PROMPT_STAGED="${git_fg}${git_bg}●"
ZSH_THEME_GIT_PROMPT_CONFLICTS="${git_fg}${git_bg}✗"
ZSH_THEME_GIT_PROMPT_AHEAD="${git_fg}${git_bg}↑"
ZSH_THEME_GIT_PROMPT_BEHIND="${git_fg}${git_bg}↓"


# Set prompt
PROMPT='%{$bg[black]%}$(prompt_main_fg) $(prompt_dir)$(git_super_status)${SEGMENT_SEPARATOR}%{${reset_color}%} $(prompt_ret_status)'
# Clear rprompt (set by git-prompt)
RPROMPT=""

unset git_fg
unset git_bg
unset git_fg_inv
unset git_bg_inv
