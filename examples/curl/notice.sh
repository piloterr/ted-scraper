#!/usr/bin/env bash
# TED Notice API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./notice.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/ted/notice" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=30-2026
