#!/usr/bin/env bash
set -euo pipefail

# Resolve directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPO_ROOT="$(cd "${PROJECT_DIR}/../.." && pwd)"

OUTPUT_DIR="${PROJECT_DIR}/output"
mkdir -p "${OUTPUT_DIR}"

# Arguments with defaults
URL="${1:-https://httpbin.org/status/200}"
TIMEOUT="${2:-10}"

# Timestamp for output file
TS="$(date +"%Y%m%d_%H%M%S")"
OUT_FILE="${OUTPUT_DIR}/healthcheck_${TS}.json"

# Activate virtual environment (skip in CI)
# GitHub Actions sets CI=true and doesn't need venv
if [ "${CI:-false}" != "true" ]; then
    if [ -f "${REPO_ROOT}/.venv/Scripts/activate" ]; then
        # Windows (Git Bash)
        source "${REPO_ROOT}/.venv/Scripts/activate"
    elif [ -f "${REPO_ROOT}/.venv/bin/activate" ]; then
        # Linux/macOS
        source "${REPO_ROOT}/.venv/bin/activate"
    else
        echo "Warning: Virtual environment not found at ${REPO_ROOT}/.venv"
        echo "Continuing with system Python..."
    fi
else
    echo "Running in CI environment, using system Python"
fi

# Run health check
python "${PROJECT_DIR}/src/health_check.py" \
  --url "${URL}" \
  --timeout "${TIMEOUT}" \
  --out "${OUT_FILE}"

echo "Saved: ${OUT_FILE}"