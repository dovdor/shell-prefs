function cdrun()
{
    dir=$1
    cmd=$2
    shift 2

    ( cd "$dir" && "$cmd" "$@" )
}

function kube_ps1_wrap()
{
    if [ "${ZPROMPT_KPS1:-yes}" = "yes" ]; then
        echo $(kube_ps1)
    else
        echo ""
    fi
}

function kube_ps1_on()
{
    export ZPROMPT_KPS1=yes
}

function kube_ps1_off()
{
    export ZPROMPT_KPS1=no
}

# AICT (AI Cost Tracker) prompt integration
# Caches aict --json output every 5 minutes, sets AICT_PS1
zmodload -F zsh/datetime b:strftime p:EPOCHSECONDS 2>/dev/null
typeset -g _AICT_LAST_UPDATE=0
typeset -g AICT_PS1=""

function _aict_update()
{
    (( EPOCHSECONDS - _AICT_LAST_UPDATE < 300 )) && return

    _AICT_LAST_UPDATE=$EPOCHSECONDS

    if ! (( $+commands[aict] && $+commands[jq] )); then
        AICT_PS1=""
        return
    fi

    local json
    json=$(aict --json 2>/dev/null) || { AICT_PS1=""; return; }

    local parts=()
    local name pct arrow
    while IFS=$'\t' read -r name pct; do
        [[ -z $name ]] && continue
        case $name in
            *[Cc]laude*) arrow="C";;
            *[Cc]ursor*) arrow="R";;
            *)           arrow="${name:0:1}";;
        esac
        if (( pct > 50 )); then
            parts+=("${arrow}▲${pct}%")
        else
            parts+=("${arrow}▼${pct}%")
        fi
    done < <(echo "$json" | jq -r '.[] | [.name, (.remaining_percent | tostring)] | @tsv' 2>/dev/null)

    if (( ${#parts[@]} > 0 )); then
        AICT_PS1="%F{cyan}${(j: :)parts}%f "
    else
        AICT_PS1=""
    fi
}

precmd_functions+=(_aict_update)

# vim: softtabstop=4 shiftwidth=4 expandtab
