
# Windows PS Script SSH Configuration for GitHub

Follow these steps to configure SSH for GitHub:

### 1. Generate Keys and Configuration
Run the `user_config.ps1` script (Open powershell as local user, if isn't administrador then run: runas /user:domain\adminuser $^)
- This will generate the public and private keys in the `~/.ssh` folder.
- It will also create a configuration file in the local folder.

### 2. Copy the Configuration File
- Copy the configuration file to the `~/.ssh` folder.

### 3. Edit the Configuration File
- Open the configuration file in a text editor and update it with your specific data.

### 4. Add the Private Key to the SSH Agent
- This allows authentication without entering the password repeatedly:
  ```bash
  ssh-add ~/.ssh/id_ed25519
  ```

### 5. Test the Connection
- Use the following command to test the SSH connection:
  ```bash
  ssh -Tv github.youruser
  ```
  - Respond with `yes` to add the host to `~/.ssh/known_hosts` if prompted.
