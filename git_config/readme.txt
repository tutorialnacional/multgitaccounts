git config --global --edit

.gitconfig        -> global git config file
.gitconfig-user   -> user config file

Cloning repository:
- git clone git@github.user1:usergithub/myrepo.git
- github.user1 defined on ~/ssh/config

After clonning, veriry the git url remote:
- git remote get-url origin

The return should be: github.user1:usergithub/myrepo.git 

If not set the correct url:
git remote set-url origin github.user1:usergithub/myrepo.git
