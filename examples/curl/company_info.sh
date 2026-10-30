#!/usr/bin/env bash
# Trustpilot Company Info API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./company_info.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/trustpilot/company/info" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.trustpilot.com/review/nordvpn.com
