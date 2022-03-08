#
# Ultimator ZSH theme
#
#
# Requirements:
# -------------
# 1. A Powerline patched font
# 2. zsh-git prompt
#
# The basic structure is taken from the agnoster theme
# Zsh-git-prompt is required for the git_super_status command
# This can be changed to use the git library of OMZ
# by changing some of the ZSH_THEME_GIT_PROMPT_XXX variables
# and including git.zsh from OMZ/lib
#
#
# License:
# --------
# MIT
#
#
# Links:
# ------
# - https://github.com/powerline/fonts
# - https://github.com/Ultimator14/zsh-git-prompt
# - https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/agnoster.zsh-theme
# - https://github.com/dbestevez/agitnoster-theme
#

# Arrow character from agnoster theme
SEGMENT_SEPARATOR=$'\ue0b0'

# Variable holding the current background color to connect segments
CURRENT_BG_COLOR="default"

#
# Helper functions
#

prompt_start() {
    # start a new prompt with given foreground and background
    # $1 = foreground
    # $2 = background
    echo -n "%{$bg[$1]%}"
    CURRENT_BG_COLOR="$1"
}

prompt_segment_transition() {
    # $1 = new background
    echo -n "%{$fg_no_bold[${CURRENT_BG_COLOR}]%}%{$bg[$1]%}${SEGMENT_SEPARATOR}"
    CURRENT_BG_COLOR="$1"
}

prompt_reset_color() {
    echo -n "%{$reset_color%}"
}

prompt_space() {
    echo -n " "
}

#
# Prompt functions
#

function prompt_ret_status() {
    # $1 = success color
    # $2 = failure color
    # $3 = success char
    # $4 = failure char
    local success="%{$fg_bold[$1]%} $3 "
    local failure="%{$fg_bold[$2]%} $4 "

    # Last command evaluation
    echo -n "%(?:${success}:${failure})"
}

function prompt_ret_status2() {
    # alternative for end of shell
    # $1 = success color
    # $2 = failure color
    local success="%{$fg_bold[$1]%}"
    local failure="%{$fg_bold[$2]%}"

    # Last command evaluation
    echo -n "%(?:${success}:${failure})$"
}

function prompt_main() {
    # $1 = user_fg
    # $2 = at_fg
    # $3 = computer_fg
    local user="%{$fg_bold[$1]%}%n"
    local at="%{$fg_bold[$2]%}@"
    local computer="%{$fg_bold[$3]%}%m"

    # Main Prompt fg creation (user@computername)
    echo -n "${user}${at}${computer}"
}

function prompt_dir() {
    # Dir prompt creation
    # $1 = foreground color
    echo -n "%{$fg_no_bold[$1]%} %(5~|.../%3~|%~) "
}

function prompt_git() {
    # Git color shortcuts
    # $1 = git_fg
    # $2 = git_bg
    # $3 = git_fg_inv
    # $4 = git_bg_inv
    local git_fg="%{$fg_no_bold[black]%}"
    local git_bg="%{$bg[yellow]%}"

    # Set git variables
    ZSH_THEME_GIT_PROMPT_PREFIX="${git_fg} \ue0a0 "
    ZSH_THEME_GIT_PROMPT_SUFFIX="${git_bg} "

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

    git_super_status
}

#
# Set prompt
#
build_prompt() {
    # change colors if user is root
    if [ $(id -u) -eq 0 ]; then
        # colors for main prompt
        local color_user_fg="red"
        local color_at_fg="red"
        local color_computer_fg="red"

        # colors for dir prompt
        local color_dir_bg="red"
    else
        # colors for main prompt
        local color_user_fg="red"
        local color_at_fg="green"
        local color_computer_fg="blue"

        # colors for dir prompt
        local color_dir_bg="blue"
    fi

    prompt_start "black"
    prompt_main "${color_user_fg}" "${color_at_fg}" "${color_computer_fg}"
    prompt_space
    prompt_segment_transition "${color_dir_bg}"
    prompt_dir "black"
    # git
    script_output=$(prompt_git)
    if [ ! -z $script_output ]
    then
        # git has output
        prompt_segment_transition "yellow"
        echo -n "$script_output"
    fi
    prompt_segment_transition "default"
    prompt_reset_color
    prompt_space
    prompt_ret_status2 "green" "red"
    prompt_reset_color
    prompt_space
}

build_prompt2() {
    # change colors if user is root
    if [ $(id -u) -eq 0 ]; then
        # colors for main prompt
        local color_user_fg="red"
        local color_at_fg="red"
        local color_computer_fg="red"

        # colors for dir prompt
        local color_dir_bg="red"
    else
        # colors for main prompt
        local color_user_fg="red"
        local color_at_fg="green"
        local color_computer_fg="blue"

        # colors for dir prompt
        local color_dir_bg="blue"
    fi

    prompt_start "white"
    prompt_ret_status "green" "red" "✔" "✘"
    prompt_segment_transition "black"
    prompt_space
    prompt_main "${color_user_fg}" "${color_at_fg}" "${color_computer_fg}"
    prompt_space
    prompt_segment_transition "${color_dir_bg}"
    prompt_dir "black"
    # git
    script_output=$(prompt_git)
    if [ ! -z $script_output ]
    then
        # git has output
        prompt_segment_transition "yellow"
        echo -n "$script_output"
    fi
    prompt_segment_transition "default"
    prompt_reset_color
    prompt_space
}

# Default prompt
PROMPT='$(build_prompt)'

# Alternatively with error status at the beginning
#PROMPT='$(build_prompt)'

# Clear rprompt (set by git-prompt)
RPROMPT=""
