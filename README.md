If you store your chef cookbooks along with your code in a private github repository, it might be useful to use that repository to provision EC2 instances. That's what these scripts aim to do.

How it works
============
You put the files make-instance.sh and bootstrap.sh.template into your own repository. The scripts expect a directory structure like this

    make-instance.sh
    bootstrap.sh.template
    chef
      + roles
      + cookbooks
      
If you run
    
    ./make-instance.sh <rolename>

the following will happen

- a bootstrap.sh file is created from bootstrap.sh.template
- a new EC2 instance will be created and started using bootstrap.sh
- bootstrap.sh installs chef-solo and its dependencies
- it then clones the git repository you where in when running make-instance.sh
- then it runs chef-solo with a run-list containing the role specified

make-instance.sh will put the private key found in git_id into boostrap.sh to clone the git repository onto the new EC2 instance via git+ssh. If make-instance can't find a file called git_id, it will ask you to create one using ssh-keygen. Use an empty passphrase when creating a key pair. The public key in git_id.pub goes into your github user profile.

Setup local machine
===================
On your local machine, you will need the following

+ ec2-api-tools (install using homebrew or apt-get)
+ environment varialbes set up correctly. See [here](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/SettingUp_CommandLine.html)
+ open-ssh (for ssh-keygen)

Licence: MIT

Have fun!
 -- regular
 
heavily inspired by [lynaghk/vagrant-ec2](http://github.com/lynaghk/vagrant-ec2)
