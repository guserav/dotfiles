# dotfiles

This repository provides several roles and playbooks for installing and configuring tools on Linux.

## Requirements
- An installed Linux distribution (Debian or Arch are recommended, others probably fail)
- Ansible

## Usage

Change the variable in vars.json to fit you. See section Variable for further explanations. This is only required if you use a role requiring the variables. In general (else it is a bug) tasks depending on a variable will be skipped if the respective variable is not set.

The configurations are split by tags. See section tags for further explanations about the tags.

To run for example a basic configuration perform the following command
```
ansible-playbook all.yml --tags "base" --ask-become-pass --extra-vars "@vars.json"
```

If you are on a distribution that supports the install procedure used by ansible then also specify `--skip-tags "only_config"`
```
ansible-playbook all.yml --tags "base" --skip-tags "only_config" --ask-become-pass --extra-vars "@vars.json"
```

Note: On some systems (e.g. CentOS) root doesn't have overall access thus it could be vise to specify another tmp dir then the default one. This can be done by adding the following to your `~/.ansible.cfg`:
```
[defaults]
remote_tmp = /tmp/ansible-$USER
```

## Variables
- `git_name`: The value to set for user.name in the gitconfig
- `git_email`: The value to set for user.email in the gitconfig
- `fish_user`: The user to create and give fish as shell
- `sudo_user`: The user to create and add as a sudoer
- `android_user`: The user to use to install android-studio. (Shouldn't be root)
- `steam_user`: The user to use to install steam with. (Schouldn't be root)

# Tags
Tags can be specified with the `--tags` option in a comma separated list (e.g. `--tags "base,gui"`).

If you want to exclude default tags use `--skip-tags`. For further explanation about tags in ansible please look into the [documentation](https://docs.ansible.com/ansible/latest/user_guide/playbooks_tags.html)

- `toolkit`:          Everything essential that I need on all systems I am working on longer (this includes systems I don't own so I don't want to clutter them). Is by default set.
- `base`:             Everything essential that I need on all my systems.
- `only_config`:      For every program specified in the roles only the configuration will be linked into home. This is indented for all distributions not compatible with the installation procedure. Is by default set.
- `laptop`:           Basic config for touchpad, wifi and backlight. (deprecated but I will maybe use it in the future)
- `gui`:              Everything else you would need on a system that is more than a terminal.
- `deprecated`:       Marks plays that are not currently used and thus not maintained.

## Git filters
Because some config files are resorted by the program they use I use git filters to reduce the amount of diff I see.

If you want to reuse them please add the following to your `.git/config` in this repository.
```
[filter "sort"]
    clean=sort
    smudge=cat
```

## Arch setup
```
pacstrap /mnt base linux linux-firmware ntfs-3g e2fsprogs lvm2 vim tmux man-db man-pages texinfo git grub efibootmgr dhcpcd
```

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
