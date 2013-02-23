#! /bin/bash
if (( $# < 1 ));
then
    echo "usage: $0 role"
    exit 1
fi
    
if [ ! -f git_id ];
then
    echo "Use ssh-keygen to create git_id and register the corresponding git_id.pub with github to allow the EC2 instance to pull from this repository."
    exit 1
fi
export GIT_URL=$(git remote -v|grep "^origin.*push.$"|awk '{print $2}')
echo "This git repository's origin remote is at $GIT_URL"
echo -n "export REPOSITORY_URL=" > xxx-git_url
echo $GIT_URL >> xxx-git_url
sed -e '/XXX-YOUR-KEY-DATA-HERE-XXX/ {' -e 'r git_id' -e 'd' -e '}' < bootstrap.sh.template |\
sed -e '/XXX-REPOSITORY_URL-XXX/ {' -e 'r xxx-git_url' -e 'd' -e '}' |\
sed "s/XXX-ROLE-XXX/$1/" > bootstrap.sh
rm xxx-git_url

echo "Creating EC2 instance"
ec2-run-instances ami-ca0e02be --instance-type m1.small --key $EC2_KEYNAME --user-data-file bootstrap.sh