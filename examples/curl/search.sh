#!/usr/bin/env bash
# TED Search API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./search.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/ted/search" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=software
