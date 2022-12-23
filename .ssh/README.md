# SRC

- [SSH Config file](https://linuxize.com/post/using-the-ssh-config-file/)
- [Superuser multiple git ssh keys for different accounts](https://superuser.com/questions/1628183/how-do-i-configure-git-to-use-multiple-ssh-keys-for-different-accounts)

## Steps post setting this up

- Once you have pulled in the changes with yadm with `yadm clone <https://<repo_url>>`, create `personal` and `work` folders to save the SSH private keys.
  - [] One thing that can be done here is from 1pass, when downloading the private key, enter passphrase for encryption (could be an autgen password string from 1pass; Could be saved in 1pass too!) and throw the file in the folder
  - [] Ansible vault and git-crypt (works with yadm) maybe better options
    - Caution on init setup if choosing this route... Something to do with secrets

- When setting up personal and work git on the same machine and the host is same, github.com, then after moving the contents of the .ssh dir, set the origin for fetch and pull to `git remote set-url gitp:SaiKrishnaMohan7/Playground.git`

- Same for the work account
