#!/usr/bin/env bash
# OpenOS/bNode profile installer
# Design policy: profiles are opt-in; services remain disabled; active-assessment tools require acknowledgement.

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
CATALOG="${REPO_DIR}/profiles/openos-tool-catalog.json"

PROFILE=""
DRY_RUN=0
ACKNOWLEDGE=0

usage() {
  cat <<'EOF'
Usage: sudo ./scripts/install-profile.sh --profile PROFILE [--dry-run] [--acknowledge]

Profiles:
  lite                 4 GB RAM-friendly desktop, hardening, and diagnostics
  desktop              General desktop/developer workstation (8 GB RAM)
  enterprise-core      Enterprise workstation and operations tooling (8 GB RAM)
  enterprise-services  Optional local-server lab (16 GB RAM; services are not started)
  security-defensive   Defensive security, auditing, monitoring, and IR (8 GB RAM)
  security-lab         Authorized security lab (16 GB RAM; acknowledgement required)

Options:
  --dry-run            Show the packages that would be installed without changing the system
  --acknowledge        Confirm that you accept the profile warning for high-impact profiles
  -h, --help           Show this help
EOF
}

log() { printf '[OpenOS] %s\n' "$*"; }
fail() { printf '[OpenOS] ERROR: %s\n' "$*" >&2; exit 1; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile) PROFILE="${2:-}"; shift 2 ;;
    --dry-run) DRY_RUN=1; shift ;;
    --acknowledge) ACKNOWLEDGE=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) fail "Unknown option: $1" ;;
  esac
done

[[ -n "$PROFILE" ]] || { usage; exit 2; }
[[ -f "$CATALOG" ]] || fail "Catalog not found: $CATALOG"

case "$PROFILE" in
  lite|desktop|enterprise-core|enterprise-services|security-defensive|security-lab) ;;
  *) fail "Unsupported profile: $PROFILE" ;;
esac

if [[ "$PROFILE" == "enterprise-services" || "$PROFILE" == "security-lab" ]]; then
  [[ "$ACKNOWLEDGE" -eq 1 ]] || fail "${PROFILE} requires --acknowledge. Review profiles/PROFILE-MATRIX.md first."
fi

if [[ "$EUID" -ne 0 ]]; then
  fail "Run with sudo. Example: sudo ./scripts/install-profile.sh --profile ${PROFILE}"
fi

if ! command -v apt-get >/dev/null 2>&1; then
  fail "This installer currently supports Debian/Ubuntu-family systems with APT."
fi

export DEBIAN_FRONTEND=noninteractive
apt-get update
if ! command -v jq >/dev/null 2>&1; then
  apt-get install -y --no-install-recommends jq
fi

mapfile -t groups < <(jq -r --arg profile "$PROFILE" '.profiles[$profile].install_groups[]' "$CATALOG")
(( ${#groups[@]} > 0 )) || fail "Profile has no install groups: $PROFILE"

declare -A wanted=()
for group in "${groups[@]}"; do
  while IFS= read -r package; do
    [[ -n "$package" ]] && wanted["$package"]=1
  done < <(jq -r --arg group "$group" '.groups[$group].tools[]' "$CATALOG")
done

candidate=()
skipped=()
for package in "${!wanted[@]}"; do
  # Packages with non-APT delivery are intentionally documented, not blindly fetched.
  if apt-cache show "$package" >/dev/null 2>&1; then
    candidate+=("$package")
  else
    skipped+=("$package")
  fi
done

IFS=$'\n' candidate=($(sort <<<"${candidate[*]}"))
IFS=$'\n' skipped=($(sort <<<"${skipped[*]}"))
unset IFS

log "Profile: $PROFILE"
log "APT packages available: ${#candidate[@]}"
log "Catalog entries requiring an external source or unavailable on this release: ${#skipped[@]}"

if (( ${#skipped[@]} > 0 )); then
  printf '%s\n' "${skipped[@]}" > "/var/log/openos-${PROFILE}-skipped-packages.txt"
  log "Skipped-item report: /var/log/openos-${PROFILE}-skipped-packages.txt"
fi

if [[ "$DRY_RUN" -eq 1 ]]; then
  printf '%s\n' "${candidate[@]}"
  exit 0
fi

apt-get install -y --no-install-recommends jq ca-certificates
if (( ${#candidate[@]} > 0 )); then
  apt-get install -y "${candidate[@]}"
fi

log "Profile installed. No optional server service has been started or exposed by this installer."
log "Review docs/ENTERPRISE-SECURITY-OPERATIONS.md before enabling services or external repositories."
