function fish_right_prompt
    set -l status_copy $status
    set -l status_code $status_copy

    set -l color_normal (set_color normal)
    set -l color_error (set_color $fish_color_error)
    set -l color "$color_normal"

    switch "$status_copy"
        case 0 "$__mono_status_last"
            set status_code
    end

    set -g __mono_status_last $status_copy

    if test "$status_copy" -ne 0
        set color "$color_error"
    end

    if set -l job_id (last_job_id)
        echo -sn "$color%$job_id$color_normal "
    end

    if test ! -z "$status_code"
        echo -sn "$color$status_code$color_normal "
    end

    if test "$CMD_DURATION$cmd_duration" -gt 250
        set -l duration (echo $CMD_DURATION$cmd_duration | humanize_duration)
        echo -sn "$color$duration$color_normal "
    else
        set -l venv_name (basename "$VIRTUAL_ENV")
        echo -sn "$color$venv_name$color_normal "
    end
end
