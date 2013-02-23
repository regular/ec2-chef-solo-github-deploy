#! /bin/bash
if [ ! -f git_id ];
then
    echo "Use ssh-keygen to create git_id and register the corresponding git_id.pub with github to allow the EC2 instance to pull from this repository."
    exit 1
fi
sed -e '/YOUR-KEY-DATA-HERE/ {' -e 'r git_id' -e 'd' -e '}' < bootstrap.sh.template > bootstrap.sh
echo "Creating EC2 instance"
ec2-run-instances ami-ca0e02be --instance-type m1.small --key $EC2_KEYNAME --user-data-file bootstrap.sh