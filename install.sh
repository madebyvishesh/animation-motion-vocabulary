#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="animation-motion-vocabulary"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="${SOURCE_DIR}/${SKILL_NAME}"

usage() {
  cat <<'EOF'
Usage:
  ./install.sh codex
  ./install.sh claude
  ./install.sh all
  ./install.sh custom /path/to/skills

Installs the animation-motion-vocabulary skill by copying:
  animation-motion-vocabulary/

into the selected agent skills directory.
EOF
}

copy_skill() {
  local target_root="$1"
  local target_dir="${target_root}/${SKILL_NAME}"

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
