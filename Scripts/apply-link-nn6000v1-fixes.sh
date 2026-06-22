#!/usr/bin/env bash
set -euo pipefail

# Run this script at the root of your forked ZNM2-LiBwrt-CI repo:
#   bash Scripts/apply-link-nn6000v1-fixes.sh
#
# It does two things:
# 1) Make device config override GENERAL.txt.
# 2) Add iStore/luci-app-store source packages to Scripts/Packages.sh.

CORE=".github/workflows/WRT-CORE.yml"
PKG="Scripts/Packages.sh"

if [ -f "$CORE" ]; then
  python3 - <<'PY'
from pathlib import Path
p = Path(".github/workflows/WRT-CORE.yml")
s = p.read_text()
old = 'cat "$GITHUB_WORKSPACE/Config/$WRT_CONFIG.txt" "$GITHUB_WORKSPACE/Config/GENERAL.txt" >> .config'
new = 'cat "$GITHUB_WORKSPACE/Config/GENERAL.txt" "$GITHUB_WORKSPACE/Config/$WRT_CONFIG.txt" >> .config'
if old in s:
    p.write_text(s.replace(old, new))
    print("OK: WRT-CORE.yml config order changed: GENERAL first, device config second.")
elif new in s:
    print("OK: WRT-CORE.yml already uses GENERAL first, device config second.")
else:
    print("WARN: Could not find the config concat line. Manually change it to:")
    print(new)
PY
else
  echo "WARN: $CORE not found"
fi

if [ -f "$PKG" ]; then
  if grep -q 'linkease/istore' "$PKG"; then
    echo "OK: iStore package source already exists in $PKG"
  else
    cat >> "$PKG" <<'EOF'

# iStore / luci-app-store dependencies
UPDATE_PACKAGE "taskd" "linkease/istore" "main" "pkg"
UPDATE_PACKAGE "luci-lib-xterm" "linkease/istore" "main" "pkg"
UPDATE_PACKAGE "luci-lib-taskd" "linkease/istore" "main" "pkg"
UPDATE_PACKAGE "luci-app-store" "linkease/istore" "main" "pkg"
EOF
    echo "OK: iStore package source appended to $PKG"
  fi
else
  echo "WARN: $PKG not found"
fi
