# git

## Build a git server

1. User setting
```bash
sudo yum install git
sudo useradd git
sudo vim /etc/passwd # last line
```
Find:
```
git:x:100x:100x::/home/git:/bin/bash
```
Change the above text to the following:
```
git:x:100x:100x::/home/git:/usr/bin/git-shell
```

2. Dirtecory setting
```bash
sudo mkdir /home/git/.ssh /home/git/git-shell-commands
sudo vim /home/git/.ssh/authorized_keys
# add your public key, the format like:
# ssh-rsa AAAAB3N...... username
sudo chmod 0600 /home/git/.ssh/authorized_keys
sudo vim /home/git/git-shell-commands/no-interactive-login
```
Insert the following:
```
printf "%s" "Hi ${USER}! You've successfully authenticated, but this server don't provide interactive shell access."
```
Then:
```bash
sudo mkdir /home/git/gitroot
sudo git init --bare /home/git/gitroot/test.git
# Output: Initialized empty Git repository in /home/git/gitroot/test.git/
sudo chown -R git:git /home/git
```

3. Test
In client:
```bash
ssh -T git@server
# Output: Hi username! You've successfully authenticated, but this server don't provide interactive shell access.
git clone git@server:gitroot/test.git
```

Notes:
If you havd had a existed repository, you should create a empty repository on your git server fir
stly.

Then add a link between git server and your repository.

```bash
git remote remove origin # optional
git remote add git@server:gitroot/repository.git
git push origin master
```

## Some learing resources

1. *git-recipes* by geeeeeeeeek@github
2. *Pro Git 2nd Edition*
3. *Learn Git Branching*
