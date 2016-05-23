# Ansible Role: Nexus

Installs Sonatype Nexus on Red Hat-based platforms.

## Requirements

This role requires the `geerlingguy.java` role.

## Role Variables

See also `defaults/main.yml`.

* `nexus_download_dir`: download path on the control machine that will be used. Defaults to `/tmp`.
* `nexus_version`: Nexus version to be installed. Defaults to `2.13.0-01`.
* `nexus_installation_dir`: installation prefix that will be used on installation hosts. Defaults to `/usr/share`.
* `nexus_work_dir`: working directory, a.k.a. sonatype-work. Defaults to `/var/nexus`.
* `nexus_port`: TCP port. Defaults to `8082`.
* `nexus_os_user`: The Nexus user, which will be created by this role. Defaults to `nexus`.
* `nexus_os_group`: The Nexus user's group, which will be created by this role. Defaults to `nexus`.
* `nexus_os_shell`: The Nexus user's shell. Defaults to `/bin/bash`.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: alexharvey.nexus, nexus_installation_dir: '/opt' }

## License

MIT.

## Acknowledgements

This module was forked from `jhinrichsen.nexus` which the author acknowledges as derived from a playbook by Alexander Ramos Jardim.

## Contributing

To run the tests:

    $ gem install bundler
    $ bundle install
    $ bundle exec kitchen test default-centos-72

Requires Docker.
