#!/usr/bin/env bash
set -euo pipefail

# Run from the project directory or repo root.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPO_ROOT="$(cd "${PROJECT_DIR}/../.." && pwd)"

OUTPUT_DIR="${PROJECT_DIR}/output"
mkdir -p "${OUTPUT_DIR}"

URL="${1:-https://httpbin.org/status/200}"
TIMEOUT="${2:-10}"

# Timestamp safe for filenames
TS="$(date +"%Y%m%d_%H%M%S")"
OUT_FILE="${OUTPUT_DIR}/healthcheck_${TS}.json"

source "${REPO_ROOT}/.venv/Scripts/activate"

python "${PROJECT_DIR}/src/health_check.py" \
  --url "${URL}" \
  --timeout "${TIMEOUT}" \
  --out "${OUT_FILE}"

echo "Saved: ${OUT_FILE}"
