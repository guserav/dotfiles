# dotfiles

This repository provides several roles and playbooks for installing and configuring tools on Linux.

## Requirements
- An installed Linux distribution (Debian or Arch are recommended, others probably fail)
- Ansible

## Usage

Change the variable in vars.json to fit you. See section Variable for further explanations.

To run for example base.yml perform the following command
'''ansible-playbook base.yml --ask-become-pass --extra-vars "@vars.json"'''

Note: On some systems (e.g. CentOS) root doesn't have overall access thus it could be vise to specify an other tmp dir then the default one. This can be done by adding the following to your ~/.ansible.cfg:
'''
[defaults]
remote_tmp = /tmp/ansible-$USER
'''

## Variables
- `git_name`: The value to set for user.name in the gitconfig
- `git_email`: The value to set for user.email in the gitconfig
- `fish_user`: The user to create and give fish as shell
- `sudo_user`: The user to create and add as a sudoer
- `android_user`: The user to use to install android-studio. (Shouldn't be root)
- `steam_user`: The user to use to install steam with. (Schouldn't be root)

# Playbooks
- base:             Everything essential that I need on all my systems.
- only_config_base: The same essential homedir configs but without installing any programs. Use this if your distro is not compatible with the installation procedure.
- laptop:           Basic config for touchpad, wifi and backlight.
- gui:              Everything else you would need on a system that is more than a terminal.
- base_toolkit.yml: Basic tools to work on a server that you don't want to pollute that much

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
