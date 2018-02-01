# dotfiles

This repository provides several roles and playbooks for installing and configuring tools on Linux.

## Requirements
- An installed Linux distribution (Debian or Arch are recommended, others probably fail)
- Ansible

## Usage

Change the variable in vars.json to fit you. See section Variable for further explanations.

To run for example base.yml perform the following command
'''ansible-playbook base.yml --ask-become-pass --extra-vars "@vars.json"'''

## Variables
- `git_name`: The value to set for user.name in the gitconfig
- `git_email`: The value to set for user.email in the gitconfig
- `fish_user`: The user to create and give fish as shell
- `sudo_user`: The user to create and add as a sudoer
- `android_user`: The user to use to install android-studio. (Shouldn't be root)
- `steam_user`: The user to use to install steam with. (Schouldn't be root)

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
