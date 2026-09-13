#!/usr/bin/env bash
#
# Convert a semicolon-delimited key=value connection string into a
# PostgreSQL connection URL:
#   postgresql://${user}:${encodedPassword}@${server}:${AURORA_PORT}/${database}
#
# Usage:
#   ./kv-to-pgconn.sh "server=...;database=...;user=...;password=...;"
#   echo "server=...;..." | ./kv-to-pgconn.sh
#
# The port defaults to 5432. Override it with either the -p/--port flag
# or the AURORA_PORT env var (the flag wins if both are given):
#   ./kv-to-pgconn.sh -p 5433 "server=...;..."
#   AURORA_PORT=5433 ./kv-to-pgconn.sh "server=...;..."

set -euo pipefail

AURORA_PORT="${AURORA_PORT:-3306}"

# Parse flags; collect non-flag args as positional (the kv string).
positional=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    -p|--port)
      if [[ $# -lt 2 ]]; then
        echo "Error: $1 requires a port number" >&2
        exit 1
      fi
      AURORA_PORT="$2"
      shift 2
      ;;
    --port=*)
      AURORA_PORT="${1#*=}"
      shift
      ;;
    -h|--help)
      echo "Usage: ${0##*/} [-p|--port PORT] \"server=...;database=...;user=...;password=...;\"" >&2
      exit 0
      ;;
    --)
      shift
      positional+=("$@")
      break
      ;;
    -*)
      echo "Error: unknown option '$1'" >&2
      exit 1
      ;;
    *)
      positional+=("$1")
      shift
      ;;
  esac
done

# Read the key-value string from the positional arg or stdin.
if [[ ${#positional[@]} -ge 1 ]]; then
  kv="${positional[0]}"
else
  kv="$(cat)"
fi

# URL-encode a string (percent-encode everything that isn't unreserved).
urlencode() {
  local raw="$1" i char out=""
  for (( i = 0; i < ${#raw}; i++ )); do
    char="${raw:i:1}"
    case "$char" in
      [a-zA-Z0-9.~_-]) out+="$char" ;;
      *) printf -v hex '%%%02X' "'$char"
         out+="$hex" ;;
    esac
  done
  printf '%s' "$out"
}

server="" database="" user="" password=""

# Split on ';' and then on the first '=' of each pair.
IFS=';' read -ra pairs <<< "$kv"
for pair in "${pairs[@]}"; do
  # Trim surrounding whitespace; skip empty fragments (e.g. trailing ';').
  pair="${pair#"${pair%%[![:space:]]*}"}"
  pair="${pair%"${pair##*[![:space:]]}"}"
  [[ -z "$pair" ]] && continue

  key="${pair%%=*}"
  value="${pair#*=}"

  case "${key,,}" in
    server)   server="$value" ;;
    database) database="$value" ;;
    user)     user="$value" ;;
    password) password="$value" ;;
  esac
done

# Validate required fields.
for field in server database user password; do
  if [[ -z "${!field}" ]]; then
    echo "Error: missing required field '$field' in input" >&2
    exit 1
  fi
done

encodedPassword="$(urlencode "$password")"

printf 'postgresql://%s:%s@%s:%s/%s\n' \
  "$user" "$encodedPassword" "$server" "$AURORA_PORT" "$database"
