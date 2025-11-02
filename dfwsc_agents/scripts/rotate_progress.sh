#!/usr/bin/env bash
set -euo pipefail
PROG="progress/ticket-progress.md"
ARCH="progress_archive"
KEEP=100

mkdir -p "$ARCH"
if [[ -f "$PROG" ]]; then
  TS=$(date +%Y-%m-%d_%H%M%S)
  cp "$PROG" "$ARCH/ticket_$TS.md"
  tail -n "$KEEP" "$PROG" > "$PROG.tmp"
  mv "$PROG.tmp" "$PROG"
  echo "Archived → $ARCH/ticket_$TS.md (kept last $KEEP lines)"
else
  echo "No $PROG found."
fi
