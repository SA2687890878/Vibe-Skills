#!/usr/bin/env bash
set -euo pipefail

PROFILE="full"
HOST_ID="codex"
TARGET_ROOT=""
PREVIEW="false"
PURGE_EMPTY_DIRS="false"
STRICT_OWNED_ONLY="false"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ADAPTER_RESOLVER="${SCRIPT_DIR}/scripts/common/resolve_vgo_adapter.py"
ADAPTER_UNINSTALLER="${SCRIPT_DIR}/scripts/uninstall/uninstall_vgo_adapter.py"

if [[ ! -f "${ADAPTER_RESOLVER}" ]]; then
  echo "[FAIL] Missing adapter resolver: ${ADAPTER_RESOLVER}" >&2
  exit 1
fi
if [[ ! -f "${ADAPTER_UNINSTALLER}" ]]; then
  echo "[FAIL] Missing adapter uninstaller: ${ADAPTER_UNINSTALLER}" >&2
  exit 1
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile) PROFILE="$2"; shift 2 ;;
    --host) HOST_ID="$2"; shift 2 ;;
    --target-root) TARGET_ROOT="$2"; shift 2 ;;
    --preview) PREVIEW="true"; shift ;;
    --purge-empty-dirs) PURGE_EMPTY_DIRS="true"; shift ;;
    --strict-owned-only) STRICT_OWNED_ONLY="true"; shift ;;
    *) echo "Unknown arg: $1"; exit 1 ;;
  esac
done

pick_python_for_adapter() {
  if command -v python3 >/dev/null 2>&1; then
    echo "python3"
    return 0
  fi
  if command -v python >/dev/null 2>&1; then
    echo "python"
    return 0
  fi
  return 1
}

adapter_query_for_host() {
  local host_id="$1"
  local property="$2"
  local python_bin=""
  python_bin="$(pick_python_for_adapter || true)"
  if [[ -z "${python_bin}" ]]; then
    echo "[FAIL] Python is required for adapter-driven host resolution metadata." >&2
    exit 1
  fi
  "${python_bin}" "${ADAPTER_RESOLVER}" --repo-root "${SCRIPT_DIR}" --host "${host_id}" --property "${property}"
}

resolve_host_id() {
  local host_id="${1:-${VCO_HOST_ID:-codex}}"
  adapter_query_for_host "${host_id}" "id"
}

resolve_default_target_root() {
  local host_id="$1"
  local env_name rel env_value
  env_name="$(adapter_query_for_host "${host_id}" 'default_target_root.env')"
  rel="$(adapter_query_for_host "${host_id}" 'default_target_root.rel')"

  env_value=""
  if [[ -n "${env_name}" && "${env_name}" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]]; then
    env_value="${!env_name:-}"
  fi

  if [[ -n "${env_value}" ]]; then
    printf '%s' "${env_value}"
    return 0
  fi
  if [[ -z "${rel}" ]]; then
    echo "[FAIL] Adapter '${host_id}' does not define default_target_root.rel." >&2
    exit 1
  fi
  if [[ "${rel}" == /* ]]; then
    printf '%s' "${rel}"
  else
    printf '%s' "${HOME}/${rel}"
  fi
}

assert_target_root_matches_host_intent() {
  local target_root="$1"
  local host_id="$2"
  local leaf normalized_target is_codex_root is_claude_root is_cursor_root is_windsurf_root is_openclaw_root
  leaf="$(basename "${target_root}")"
  leaf="$(printf '%s' "${leaf}" | tr '[:upper:]' '[:lower:]')"
  normalized_target="$(printf '%s' "${target_root}" | tr '\\' '/' | tr '[:upper:]' '[:lower:]')"
  normalized_target="${normalized_target%/}"
  is_codex_root="false"
  is_claude_root="false"
  is_cursor_root="false"
  is_windsurf_root="false"
  is_openclaw_root="false"
  [[ "${leaf}" == ".codex" ]] && is_codex_root="true"
  [[ "${leaf}" == ".claude" ]] && is_claude_root="true"
  [[ "${leaf}" == ".cursor" ]] && is_cursor_root="true"
  [[ "${normalized_target}" == */.codeium/windsurf ]] && is_windsurf_root="true"
  [[ "${leaf}" == ".openclaw" ]] && is_openclaw_root="true"
  local is_opencode_root="false"
  [[ "${leaf}" == ".opencode" || "${normalized_target}" == */.config/opencode ]] && is_opencode_root="true"
  if [[ "${host_id}" == "codex" && ( "${is_claude_root}" == "true" || "${is_windsurf_root}" == "true" || "${is_openclaw_root}" == "true" ) ]]; then
    echo "[FAIL] Target root '${target_root}' looks like a non-Codex host root, but host='codex'." >&2
    exit 1
  fi
  if [[ "${host_id}" == "codex" && "${is_cursor_root}" == "true" ]]; then
    echo "[FAIL] Target root '${target_root}' looks like a Cursor home, but host='codex'." >&2
    exit 1
  fi
  if [[ "${host_id}" == "codex" && "${is_opencode_root}" == "true" ]]; then
    echo "[FAIL] Target root '${target_root}' looks like an OpenCode root, but host='codex'." >&2
    exit 1
  fi
  if [[ "${host_id}" == "claude-code" && ( "${is_codex_root}" == "true" || "${is_windsurf_root}" == "true" || "${is_openclaw_root}" == "true" ) ]]; then
    echo "[FAIL] Target root '${target_root}' looks like a non-Claude host root, but host='claude-code'." >&2
    exit 1
  fi
  if [[ "${host_id}" == "claude-code" && ( "${is_cursor_root}" == "true" || "${is_opencode_root}" == "true" ) ]]; then
    echo "[FAIL] Target root '${target_root}' does not match host='claude-code'." >&2
    exit 1
  fi
  if [[ "${host_id}" == "cursor" && ( "${is_codex_root}" == "true" || "${is_claude_root}" == "true" || "${is_windsurf_root}" == "true" || "${is_openclaw_root}" == "true" || "${is_opencode_root}" == "true" ) ]]; then
    echo "[FAIL] Target root '${target_root}' does not match host='cursor'." >&2
    exit 1
  fi
  if [[ "${host_id}" == "windsurf" && ( "${is_codex_root}" == "true" || "${is_claude_root}" == "true" || "${is_openclaw_root}" == "true" || "${is_cursor_root}" == "true" || "${is_opencode_root}" == "true" ) ]]; then
    echo "[FAIL] Target root '${target_root}' does not match host='windsurf'." >&2
    exit 1
  fi
  if [[ "${host_id}" == "openclaw" && ( "${is_codex_root}" == "true" || "${is_claude_root}" == "true" || "${is_windsurf_root}" == "true" || "${is_cursor_root}" == "true" || "${is_opencode_root}" == "true" ) ]]; then
    echo "[FAIL] Target root '${target_root}' does not match host='openclaw'." >&2
    exit 1
  fi
  if [[ "${host_id}" == "opencode" && ( "${is_codex_root}" == "true" || "${is_claude_root}" == "true" || "${is_cursor_root}" == "true" || "${is_windsurf_root}" == "true" || "${is_openclaw_root}" == "true" ) ]]; then
    echo "[FAIL] Target root '${target_root}' looks like a non-OpenCode host root, but host='opencode'." >&2
    exit 1
  fi
}

HOST_ID="$(resolve_host_id "${HOST_ID}")"
if [[ -z "${TARGET_ROOT}" ]]; then
  TARGET_ROOT="$(resolve_default_target_root "${HOST_ID}")"
fi
assert_target_root_matches_host_intent "${TARGET_ROOT}" "${HOST_ID}"

PYTHON_BIN="$(pick_python_for_adapter || true)"
if [[ -z "${PYTHON_BIN}" ]]; then
  echo "[FAIL] Python is required for unified uninstall." >&2
  exit 1
fi

ARGS=(
  "${ADAPTER_UNINSTALLER}"
  --repo-root "${SCRIPT_DIR}"
  --target-root "${TARGET_ROOT}"
  --host "${HOST_ID}"
  --profile "${PROFILE}"
)
if [[ "${PREVIEW}" == "true" ]]; then ARGS+=(--preview); fi
if [[ "${PURGE_EMPTY_DIRS}" == "true" ]]; then ARGS+=(--purge-empty-dirs); fi
if [[ "${STRICT_OWNED_ONLY}" == "true" ]]; then ARGS+=(--strict-owned-only); fi

exec "${PYTHON_BIN}" "${ARGS[@]}"
