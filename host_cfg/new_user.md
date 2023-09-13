## Creating a new user, giving it a password, making it accessible via SSH

### Creating the user

Create a user by running

`sudo useradd -s /bin/bash -d /home/USER_NAME/ -m -G sudo USER_NAME`

Add the user a password by running

`sudo passwd USER_NAME`

To better understand what each flag does, read what follows:
 - `-s /bin/bash` Set /bin/bash as login shell of the new account
 - `-d /home/USER_NAME/` Set /home/USER_NAME/ as home directory of the new Ubuntu account
 - `-m` Create the user’s home directory
 `-G sudo` Make sure USER_NAME user can sudo i.e. give admin access to the new account

### Permitting login with SSH

On your system, use the `cat` command to view your current RSA/ed25519 public key on the desktop:

```bash
cat ~/.ssh/id_ed25519.pub
cat ~/.ssh/id_rsa.pub
```

Run the following commands to install the key on the server

```bash
sudo mkdir /home/USER_NAME/.ssh/
sudo chmod 0700 /home/USER_NAME/.ssh/
sudo -- sh -c "echo 'YOUR_SSH_PRIVATE_KEY USER_NAME@MACHINE' > /home/USER_NAME/.ssh/authorized_keys"
sudo chown -R USER_NAME:USER_NAME /home/USER_NAME/.ssh/
```

Now, you can enter in the server via SSH with `ssh USER_NAME@YOUR_SERVER_IP_OR_NAME`

To delete a user run `sudo userdel USER_NAME`