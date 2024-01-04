# name: lambda
# author: me somewhat
# run funced fish_prompt as root to edit
function fish_prompt
    set -l last_status $status
    # Prompt status only if it's not 0
    set -l stat
    if test $last_status -ne 0
        set stat (set_color red)"[$last_status]"(set_color normal)
    end

    string join '' -- 'λ '(prompt_pwd) (set_color normal) $stat '/ '
end
