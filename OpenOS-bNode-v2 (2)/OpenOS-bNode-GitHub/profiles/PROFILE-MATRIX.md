# OpenOS/bNode Profile Matrix

> **Default principle:** OpenOS/bNode does not enable every tool or server by default. A useful operating system is dependable before it is expansive. Profiles install a deliberate collection of tools, while server workloads remain opt-in.

| Profile | Intended use | Minimum RAM | Services enabled automatically | Suitable for 4 GB RAM |
|---|---|---:|---|---|
| `lite` | Privacy-focused desktop, documents, basic diagnostics, hardening | 4 GB | No | **Yes** |
| `desktop` | General workstation plus local development | 8 GB | No | No |
| `enterprise-core` | Operations workstation, automation, virtualization clients, backups | 8 GB | No | No |
| `enterprise-services` | Local enterprise server lab or dedicated server | 16 GB | No | No |
| `security-defensive` | Endpoint protection, audit, monitoring, incident triage | 8 GB | No | No |
| `security-lab` | Authorized security research in an isolated lab | 16 GB | No | No |

The **Lite** profile is the correct starting point for a 4 GB computer. It does not run Nextcloud, Mailcow, Open WebUI, Ollama models, Grafana, databases, or multiple monitoring services locally. Those workloads should be enabled one at a time, or hosted on a separate server.

## Profile Rules

| Rule | Why it matters |
|---|---|
| Install tools through signed distribution repositories where available. | It reduces supply-chain risk and allows the package manager to deliver security updates. |
| Keep high-memory server components optional. | Services such as local AI, mail stacks, databases, and observability platforms can overwhelm a desktop with limited RAM. |
| Do not make lab testing tools part of the default desktop install. | This avoids needless attack surface and keeps the default system suited to everyday use. |
| Enable a server only after configuring its credentials, access control, TLS, backups, and firewall rules. | An installed service is not a secure service until it is configured and maintained. |

## Tool Count

The catalog is intentionally broader than any one installation profile. It contains **200+ named tools and services**, arranged by function and delivery method. Availability varies by Ubuntu/Debian release and enabled repositories. The installer verifies package availability before installing and reports skipped items instead of failing the entire profile.

## References

[1]: https://www.kali.org/docs/general-use/metapackages/ "Kali Linux Metapackages"
[2]: https://docs.crowdsec.net/u/getting_started/installation/linux "CrowdSec: Install on Linux"
[3]: https://packages.debian.org/sid/utils/lynis "Debian package information: Lynis"
