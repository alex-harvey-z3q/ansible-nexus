# Ansible Role: Nexus Repository

Installs Sonatype Nexus Repository 3 on systemd-based Enterprise Linux hosts.

This role has been modernised for the EL 9/10 era. It no longer installs Nexus
Repository 2, no longer uses SysV init scripts, and no longer depends on the
legacy `geerlingguy.java` role.

## Requirements

- Ansible 2.15 or newer.
- Enterprise Linux 9 or 10 family host.
- `systemd`.
- x86-64 or AArch64 architecture.

The Sonatype Linux archives include a runtime for supported platforms. If you
want to install and use an operating system Java package instead, set
`nexus_manage_java: true` and configure `nexus_java_package` and
`nexus_java_home`.

## Role Variables

See `defaults/main.yml` for the full list.

| Variable | Default | Description |
| --- | --- | --- |
| `nexus_version` | `3.93.2-01` | Nexus Repository version, including Sonatype build suffix. |
| `nexus_download_url` | derived | Archive URL for the selected version and architecture. |
| `nexus_download_checksum` | derived | Checksum for `get_url`, for example `sha256:<digest>`. |
| `nexus_install_dir` | `/opt/nexus` | Parent directory for versioned Nexus installations. |
| `nexus_current_path` | `/opt/nexus/current` | Stable symlink to the active install. |
| `nexus_data_dir` | `/var/sonatype-work/nexus3` | Nexus data directory. |
| `nexus_user` | `nexus` | System user used to run Nexus. |
| `nexus_group` | `nexus` | System group used to run Nexus. |
| `nexus_host` | `0.0.0.0` | HTTP bind address. |
| `nexus_port` | `8081` | HTTP port. |
| `nexus_context_path` | `/` | Nexus web context path. |
| `nexus_manage_java` | `false` | Install an OS Java package. |
| `nexus_java_package` | `java-17-openjdk-headless` | Java package to install when enabled. |
| `nexus_wait_for_start` | `true` | Wait for the local HTTP endpoint after starting the service. |

## Example Playbook

```yaml
---
- name: Install Nexus Repository
  hosts: nexus
  become: true
  roles:
    - role: alexharvey.nexus
      nexus_download_checksum: "sha256:<digest>"
```

## Testing

Install modern Ansible role tooling, then run:

```console
python3 -m pip install -r requirements-dev.txt
ansible-lint
yamllint .
molecule test
```

The Molecule scenario targets Rocky Linux 9 in Docker and uses systemd inside
the container. EL 10 support is declared in role metadata and should be added to
the Molecule matrix once stable EL 10 container images are available in your
chosen registry.

## License

MIT.
