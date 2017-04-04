#echo "set -xeu" > env
uniq -u <(cat <(printenv | sort) <(source config ; printenv | sort) | sort) > env
