function get_aws_log
{
    aws=`which aws`
    if [[ ! -f $aws ]]; then
        echo "can't find aws"
        return 1
    fi

    if [[ "x$1" == "x" ]]; then
        echo "usage: get_aws_log <instance-id>"
        return 1
    fi

    aws ec2 get-console-output --instance-id $1 --output text --query Output
}

function ecr_list_tags
{
    repo=$1
    aws ecr list-images --repository-name $1 --filter 'tagStatus=TAGGED' | jq '.[][].imageTag'
}

function realpath()
{
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

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
# vim: softtabstop=4 shiftwidth=4 expandtab
