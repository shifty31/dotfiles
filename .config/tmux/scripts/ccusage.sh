#!/bin/sh
# Prints today's Claude token usage and cost for the tmux status bar, e.g. "112.2M $86.29".
# Results are cached so ccusage (node) isn't launched on every status refresh.

cache="${TMPDIR:-/tmp}/tmux-ccusage-$(id -u)"
ttl=60

if [ -f "$cache" ]; then
	age=$(( $(date +%s) - $(stat -f %m "$cache") ))
	if [ "$age" -lt "$ttl" ]; then
		cat "$cache"
		exit 0
	fi
fi

bin=$(command -v ccusage 2>/dev/null)
if [ -z "$bin" ]; then
	# tmux's #() shell doesn't load fnm, so look in its node installs directly
	for b in "${FNM_DIR:-$HOME/.local/share/fnm}"/node-versions/*/installation/bin/ccusage; do
		[ -x "$b" ] && bin="$b"
	done
fi
[ -z "$bin" ] && exit 0
# ccusage's shebang needs node, which lives next to it
PATH="$(dirname "$bin"):$PATH"

totals=$("$bin" daily --json --since "$(date +%Y%m%d)" 2>/dev/null | jq -r '
	.totals
	| (.totalTokens // 0) as $t
	| (if $t >= 1000000 then "\($t / 1000000 | . * 10 | round / 10)M"
	   elif $t >= 1000 then "\($t / 1000 | . * 10 | round / 10)K"
	   else "\($t)" end)
	  + " " + (.totalCost // 0 | tostring)
')
[ -z "$totals" ] && exit 0

out=$(printf '%s $%.2f' $totals)
printf '%s' "$out" | tee "$cache"
