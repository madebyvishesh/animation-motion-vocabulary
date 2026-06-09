#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="animation-motion-vocabulary"
REPO="madebyvishesh/animation-motion-vocabulary"
REF="${ANIMATION_VOCAB_REF:-main}"
SCRIPT_PATH="${BASH_SOURCE[0]-$0}"
SOURCE_DIR="$(cd "$(dirname "${SCRIPT_PATH}")" 2>/dev/null && pwd || pwd)"
SKILL_DIR="${SOURCE_DIR}/${SKILL_NAME}"
TMP_DIR=""

cleanup() {
  if [[ -n "${TMP_DIR}" && -d "${TMP_DIR}" ]]; then
    rm -rf "${TMP_DIR}"
  fi
}

trap cleanup EXIT

usage() {
  cat <<'EOF'
Usage:
  ./install.sh codex
  ./install.sh claude
  ./install.sh all
  ./install.sh custom /path/to/skills

Remote install:
  curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/main/install.sh | bash -s -- codex
  curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/main/install.sh | bash -s -- claude

Installs the animation-motion-vocabulary skill by copying:
  animation-motion-vocabulary/

into the selected agent skills directory.
EOF
}

ensure_skill_dir() {
  if [[ -f "${SKILL_DIR}/SKILL.md" ]]; then
    return
  fi

  if ! command -v curl >/dev/null 2>&1; then
    echo "Error: curl is required for remote installation." >&2
    exit 1
  fi

  if ! command -v tar >/dev/null 2>&1; then
    echo "Error: tar is required for remote installation." >&2
    exit 1
  fi

  TMP_DIR="$(mktemp -d)"
  local archive="${TMP_DIR}/repo.tar.gz"
  local url="https://github.com/${REPO}/archive/refs/heads/${REF}.tar.gz"

  echo "Downloading ${REPO}@${REF}..."
  curl -fsSL "${url}" -o "${archive}"
  tar -xzf "${archive}" -C "${TMP_DIR}" --strip-components=1
  SKILL_DIR="${TMP_DIR}/${SKILL_NAME}"
}

copy_skill() {
  local target_root="$1"
  local target_dir="${target_root}/${SKILL_NAME}"

  ensure_skill_dir

  if [[ ! -f "${SKILL_DIR}/SKILL.md" ]]; then
    echo "Error: ${SKILL_DIR}/SKILL.md not found." >&2
    exit 1
  fi

  mkdir -p "${target_root}"
  rm -rf "${target_dir}"
  cp -R "${SKILL_DIR}" "${target_dir}"
  find "${target_dir}" -name '._*' -type f -delete 2>/dev/null || true
  echo "Installed ${SKILL_NAME} to ${target_dir}"
}

case "${1:-}" in
  codex)
    copy_skill "${HOME}/.codex/skills"
    ;;
  claude)
    copy_skill "${HOME}/.claude/skills"
    ;;
  all)
    copy_skill "${HOME}/.codex/skills"
    copy_skill "${HOME}/.claude/skills"
    ;;
  custom)
    if [[ -z "${2:-}" ]]; then
      echo "Error: custom install requires a target directory." >&2
      usage
      exit 1
    fi
    copy_skill "$2"
    ;;
  -h|--help|help|"")
    usage
    ;;
  *)
    echo "Error: unknown install target: $1" >&2
    usage
    exit 1
    ;;
esac
