# OpenOS/bNode Enterprise & Security Operations Guide

## Purpose and Scope

The OpenOS/bNode **Enterprise & Security Catalog** adds **405 unique named tools and services** to the project catalog. This is a curated availability list, not a promise that every component is installed, enabled, or appropriate for every computer. A desktop that starts every database, mail system, observability platform, and security sensor would be slow, difficult to maintain, and unsafe to expose.

> **Operating principle:** Install a profile intentionally, activate only the services you administer, and keep active-assessment tools in an authorized lab.

The catalog uses the signed Ubuntu/Debian package repositories first. It records tools that require their own signed upstream repository, a pinned container image, or a manual package review rather than downloading unknown code during an operating-system build. This protects the supply chain and makes updates auditable.

## Profile Selection

| Profile | Focus | Minimum RAM | Recommended for | Server processes started automatically |
|---|---|---:|---|---|
| `lite` | Desktop productivity, endpoint hardening, diagnostics | 4 GB | A 4 GB laptop or low-power desktop | **No** |
| `desktop` | General workstation and local development | 8 GB | Daily productivity plus development | **No** |
| `enterprise-core` | Automation, virtualization clients, operations, backups | 8 GB | IT and platform engineering workstations | **No** |
| `enterprise-services` | Local server lab and self-hosted applications | 16 GB | Dedicated VM or server | **No** |
| `security-defensive` | Audit, hardening, monitoring, forensics, incident triage | 8 GB | Defensive security workstation | **No** |
| `security-lab` | Authorized assessment and security research | 16 GB | Isolated lab VM | **No** |

For a computer with **4 GB RAM**, start with `lite`. Run web-based services, local AI models, email stacks, databases, Grafana, and multi-container platforms on a separate machine or a cloud VM. This is not a restriction of the catalog; it is an operational decision that keeps the desktop responsive.

## Installation Workflow

Review which repository packages are available before installing a profile:

```bash
cd OpenOS-bNode-GitHub
sudo ./scripts/install-profile.sh --profile lite --dry-run
```

Install the Lite desktop profile:

```bash
sudo ./scripts/install-profile.sh --profile lite
```

Install an enterprise workstation profile:

```bash
sudo ./scripts/install-profile.sh --profile enterprise-core
```

High-impact profiles require an explicit acknowledgement after the administrator has reviewed the resource and authorized-use warning:

```bash
sudo ./scripts/install-profile.sh --profile security-lab --acknowledge
```

The installer refreshes APT metadata, installs `jq` when needed to read the catalog, checks each named package against the currently configured APT repositories, and installs only packages that are available. It writes skipped items to `/var/log/openos-<profile>-skipped-packages.txt`; skipped items should be reviewed against their official source documentation, not force-installed from random scripts.

## Enterprise Capability Areas

| Area | Examples in catalog | Operational guidance |
|---|---|---|
| Platform engineering | Podman, Docker, Buildah, Skopeo, Cockpit, libvirt | Use rootless containers where practical; separate production workloads from desktop workloads. |
| Automation and configuration | Ansible, cloud-init, OpenTofu, Packer, shell linting | Store configuration in version control, require code review, and protect secrets. |
| Storage and resilience | Restic, BorgBackup, rclone, rsync, SMART, LVM, encryption | Define restore tests; a backup that has never been restored is not a verified backup. |
| Observability | Prometheus, Grafana, Netdata, rsyslog, Alertmanager | Deploy on an 8–16 GB server or remote VM; restrict dashboards and telemetry endpoints. |
| Collaboration | Nextcloud, ONLYOFFICE, Element, Gitea, Vaultwarden | Prefer a reverse proxy with TLS, strong administrator accounts, backup retention, and updates. |
| Identity and access | FreeIPA, Keycloak, Authelia, Authentik, MFA tools | Use a dedicated identity service; do not deploy one casually on a 4 GB laptop. |

Cockpit can manage host resources, machines, packages, networks, and containers. Its Podman integration uses Podman’s REST API, so treat Cockpit access as administrative access and place it behind a firewall or VPN.[1]

## Defensive Security Capability Areas

| Area | Examples in catalog | Safe use |
|---|---|---|
| Endpoint hardening | AppArmor, auditd, AIDE, Lynis, kernel-hardening-checker, debsums | Apply a baseline, review findings, and make changes through documented configuration management. |
| Malware and rootkit detection | ClamAV, rkhunter, chkrootkit, YARA | Use scheduled scans and investigate alerts; do not treat a single scanner result as conclusive proof. |
| Access defense | UFW or nftables, Fail2ban, CrowdSec, OpenVPN, WireGuard | Select **one** host firewall manager, allow only required ports, and keep remote administration behind VPN or strong MFA. |
| Network monitoring | Suricata, Zeek, tcpdump, Wireshark/TShark, Nmap, ntopng | Capture and inspect traffic only where policy and authorization permit. |
| Forensics and incident response | Autopsy, Sleuth Kit, TestDisk, Foremost, Volatility 3, YARA | Preserve evidence read-only, record chain of custody, and work from copies. |
| DevSecOps | Semgrep, Trivy, Syft, Grype, Checkov, Gitleaks, OSV-Scanner | Run security checks in CI and remediate verified findings rather than merely collecting reports. |

Lynis is packaged by Debian as a system-auditing tool for hardening Unix-like systems and can assist with automated audits.[2] CrowdSec’s documentation distinguishes its detection engine from the remediation component that enforces decisions, so OpenOS/bNode keeps detection and blocking choices explicit.[3]

## Authorized Security-Lab Boundary

The `security-lab` profile groups tools for training, security research, and authorized assessment. It is **not** the default desktop profile. Network discovery, credential testing, interception, fuzzing, and exploitation-oriented utilities can affect other systems, so they must only be used where the operator has written authorization and a defined scope.

Kali documents metapackages as groups that let users choose how much of a security toolkit to install.[4] OpenOS/bNode follows the same grouping idea while keeping its own base system separate: the catalog makes tools available by purpose, but it does not replace a security assessment methodology, permission, or a controlled lab.

## Service Exposure Checklist

Before enabling a local service, document the answer to every item below.

| Control | Required decision |
|---|---|
| Purpose | What business or personal need does the service address? |
| Location | Is it running on the desktop, a dedicated server, or a VM? |
| Authentication | Which administrator account, MFA method, and least-privilege roles are configured? |
| Network | Which ports are necessary, and who can reach them? |
| Encryption | Is TLS enabled with certificates managed through a trusted process? |
| Backups | What is backed up, where is it stored, and when was restore tested? |
| Updates | Who applies updates, and how are maintenance windows recorded? |
| Monitoring | Which logs and health checks indicate an outage or compromise? |

## External Repositories and Containers

Some catalog entries are not packaged by every Ubuntu or Debian release. For these entries, use the project’s official installation documentation and verify signing keys, package origin, image digest, and compatibility before adding a repository. Do not use a blind `curl | sudo sh` command in a production build. CrowdSec’s manual Linux installation documentation, for example, uses a GPG keyring and a `signed-by` APT entry rather than treating arbitrary network output as privileged shell code.[3]

For containerized services, prefer a named version or digest, persistent volumes with restrictive permissions, a non-root user when the image supports it, and an isolated network. Do not expose the container directly to the public internet until a reverse proxy, TLS, backup plan, and authentication controls are in place.

## Updates and Maintenance

```bash
# Review available updates
sudo apt update
apt list --upgradable

# Apply supported security updates
sudo apt upgrade

# Review host hardening findings
sudo lynis audit system

# Review firewall rules (choose UFW or nftables; do not run competing managers)
sudo ufw status verbose
sudo nft list ruleset

# Check system logs
sudo journalctl -p warning..alert --since "24 hours ago"
```

Use staged updates for a server that hosts important data. Update a test VM first, verify the service, then update production during an agreed maintenance window.

## Catalog Files

| Path | Purpose |
|---|---|
| `profiles/openos-tool-catalog.json` | Machine-readable catalog with 405 unique named entries and six profiles. |
| `profiles/PROFILE-MATRIX.md` | Profile scope, memory recommendations, and selection rules. |
| `apps/enterprise-tools-v3.json` | Enterprise tooling manifest and official-source references. |
| `apps/cybersecurity-tools-v3.json` | Defensive-security and authorized-lab manifest. |
| `scripts/install-profile.sh` | APT-aware profile installer with dry-run and skipped-package report. |

## References

[1]: https://github.com/cockpit-project/cockpit-podman "cockpit-project/cockpit-podman"
[2]: https://packages.debian.org/sid/utils/lynis "Debian package information: Lynis"
[3]: https://docs.crowdsec.net/u/getting_started/installation/linux "CrowdSec: Install on Linux"
[4]: https://www.kali.org/docs/general-use/metapackages/ "Kali Linux Metapackages"
[5]: https://documentation.wazuh.com/current/installation-guide/wazuh-agent/wazuh-agent-package-linux.html "Wazuh agent deployment on Linux"
[6]: https://docs.semgrep.dev/getting-started/quickstart-ce "Semgrep Community Edition quick start"
