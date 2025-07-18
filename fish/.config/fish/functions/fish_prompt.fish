# TokyoNight Color Palette
set -g foreground c0caf5
set -g selection 33467C
set -g comment 565f89
set -g red f7768e
set -g orange ff9e64
set -g yellow e0af68
set -g green 9ece6a
set -g purple 9d7cd8
set -g cyan 7dcfff
set -g pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment

set __fish_git_prompt_show_informative_status true
set __fish_git_prompt_showcolorhints yes
set __fish_git_prompt_showupstream informative
set __fish_git_prompt_showdirtystate yes
set __fish_git_prompt_char_cleanstate '✔'
set __fish_git_prompt_char_dirtystate '◆'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'
set __fish_git_prompt_char_upstream_diverged '<>'
set __fish_git_prompt_color_upstream cyan
set __fish_git_prompt_color_branch magenta
set -U fish_prompt_pwd_dir_length 0

set -U fish_color_cwd blue
set -U fish_color_cwd_root red

function fish_prompt --description 'Write out the prompt'
    set -l _display_status $status

    set -l git (fish_git_prompt)

    set -l prompt '⟫ '

    set -l prompt_color $red

    if test $_display_status -eq 0
        set prompt_color $green
    end

    set -l pwd (prompt_pwd)

    echo -n -s -e (set_color $fish_color_cwd) $pwd $git (set_color $purple) ' ' (date +%H:%M:%S) '\n' (set_color $prompt_color) $prompt
end
