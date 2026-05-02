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

# Claude Code wrapper: set iTerm2 tab title during session
function claude() {
    echo -ne "\e]1;Claude: ${PWD##*/}\a"
    command claude "$@"
    echo -ne "\e]1;\a"
}

# vim: softtabstop=4 shiftwidth=4 expandtab
