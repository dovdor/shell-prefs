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
