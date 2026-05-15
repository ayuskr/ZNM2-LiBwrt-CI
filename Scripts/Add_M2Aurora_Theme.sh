#!/bin/sh
set -e

echo "==== Add luci-theme-m2aurora ===="

THEME_DIR="$GITHUB_WORKSPACE/wrt/package/custom/luci-theme-m2aurora"

rm -rf "$THEME_DIR"
mkdir -p "$THEME_DIR/htdocs/luci-static/m2aurora"
mkdir -p "$THEME_DIR/root/usr/share/luci/themes"
mkdir -p "$THEME_DIR/root/usr/share/ucode/luci/template/themes/m2aurora"
mkdir -p "$THEME_DIR/root/etc/uci-defaults"

cat > "$THEME_DIR/Makefile" <<'EOF'
include $(TOPDIR)/rules.mk

LUCI_TITLE:=M2 Aurora Glass Theme
LUCI_DEPENDS:=+luci-base
LUCI_PKGARCH:=all

PKG_NAME:=luci-theme-m2aurora
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(TOPDIR)/feeds/luci/luci.mk
EOF

cat > "$THEME_DIR/root/usr/share/luci/themes/m2aurora.json" <<'EOF'
{
  "name": "M2 Aurora Glass",
  "description": "ZN M2 Aurora Glass theme",
  "author": "Ayu",
  "media": "m2aurora"
}
EOF

cat > "$THEME_DIR/htdocs/luci-static/m2aurora/cascade.css" <<'EOF'
:root {
    --m2-text: #0f172a;
    --m2-muted: rgba(51,65,85,.68);
    --m2-blue: #2563eb;
    --m2-cyan: #06b6d4;
}

html,
body {
    min-height: 100%;
}

body {
    color: var(--m2-text) !important;
    background:
        radial-gradient(circle at 12% 10%, rgba(96,165,250,.25), transparent 30%),
        radial-gradient(circle at 88% 18%, rgba(167,139,250,.24), transparent 32%),
        radial-gradient(circle at 80% 88%, rgba(45,212,191,.18), transparent 34%),
        linear-gradient(135deg, #edf4ff 0%, #f5f0ff 46%, #ecfbff 100%) !important;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Microsoft YaHei", sans-serif !important;
}

header,
.main > header,
#mainmenu {
    background: rgba(255,255,255,.50) !important;
    border-bottom: 1px solid rgba(255,255,255,.48) !important;
    backdrop-filter: blur(22px) !important;
    -webkit-backdrop-filter: blur(22px) !important;
    box-shadow: 0 10px 36px rgba(100,116,139,.10) !important;
}

#maincontent,
.main,
.container,
.container-fluid {
    background: transparent !important;
}

#mainmenu .active > a,
#mainmenu a.active,
.tabs > li.active > a,
.tabs > li > a:hover {
    color: var(--m2-text) !important;
    background: rgba(15,23,42,.12) !important;
    border-radius: 16px !important;
}

#mainmenu a,
.tabs a {
    color: #0f172a !important;
    font-weight: 800 !important;
}

.dropdown-menu,
.menu,
.modal,
.cbi-section,
.cbi-map,
.panel,
.card,
.table,
table {
    border-radius: 24px !important;
    background: rgba(255,255,255,.46) !important;
    border: 1px solid rgba(255,255,255,.58) !important;
    box-shadow:
        0 18px 56px rgba(100,116,139,.12),
        inset 0 1px 0 rgba(255,255,255,.52) !important;
    backdrop-filter: blur(22px) !important;
    -webkit-backdrop-filter: blur(22px) !important;
}

input,
select,
textarea {
    border-radius: 14px !important;
    border: 1px solid rgba(255,255,255,.68) !important;
    background: rgba(255,255,255,.62) !important;
    color: var(--m2-text) !important;
    box-shadow:
        0 10px 26px rgba(100,116,139,.10),
        inset 0 1px 0 rgba(255,255,255,.45) !important;
}

button,
.btn,
.cbi-button,
.cbi-button-apply,
.cbi-button-save {
    border: 0 !important;
    border-radius: 14px !important;
    color: white !important;
    background: linear-gradient(135deg, var(--m2-blue), var(--m2-cyan)) !important;
    box-shadow: 0 14px 28px rgba(37,99,235,.24) !important;
    font-weight: 900 !important;
}
EOF

cat > "$THEME_DIR/root/usr/share/ucode/luci/template/themes/m2aurora/sysauth.ut" <<'EOF'
{% include("themes/aurora/sysauth") %}

<style>
html,
body {
    min-height: 100%;
}

body {
    background:
        radial-gradient(circle at 16% 14%, rgba(96,165,250,.30), transparent 28%),
        radial-gradient(circle at 84% 18%, rgba(167,139,250,.32), transparent 34%),
        radial-gradient(circle at 76% 88%, rgba(45,212,191,.20), transparent 34%),
        linear-gradient(135deg, #edf4ff 0%, #f5f0ff 46%, #ecfbff 100%) !important;
}

header,
#mainmenu,
#submenu,
.tabs,
.main-left,
.main-right,
aside {
    display: none !important;
}

body::before,
body::after {
    display: none !important;
    content: none !important;
}

#maincontent,
main,
.container,
.container-fluid,
.main {
    min-height: 100vh !important;
    width: 100% !important;
    max-width: none !important;
    margin: 0 !important;
    padding: 24px !important;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    box-sizing: border-box !important;
    background: transparent !important;
}

form {
    width: min(520px, 92vw) !important;
    padding: 46px 46px 42px !important;
    border-radius: 36px !important;
    background: rgba(255,255,255,.52) !important;
    border: 1px solid rgba(255,255,255,.68) !important;
    box-shadow:
        0 34px 100px rgba(100,116,139,.24),
        inset 0 1px 0 rgba(255,255,255,.62) !important;
    backdrop-filter: blur(28px) !important;
    -webkit-backdrop-filter: blur(28px) !important;
    position: relative !important;
    z-index: 2 !important;
    overflow: hidden !important;
}

form::before {
    content: "" !important;
    display: block !important;
    height: 118px !important;
}

form::after {
    display: none !important;
    content: none !important;
}

form > div:first-child,
form .brand,
form .logo,
form .sysauth,
form .login-title,
form .login-header,
form h1,
form h2,
form h3,
form legend,
.cbi-section h3 {
    display: none !important;
}

input[type="text"],
input[type="password"],
input[name="luci_username"],
input[name="luci_password"] {
    width: 100% !important;
    height: 58px !important;
    border-radius: 18px !important;
    border: 1px solid rgba(255,255,255,.72) !important;
    background: rgba(255,255,255,.66) !important;
    color: #0f172a !important;
    font-size: 18px !important;
    font-weight: 800 !important;
    padding: 0 18px !important;
    box-sizing: border-box !important;
}

input[type="submit"],
button[type="submit"],
.btn,
.cbi-button,
.cbi-button-apply {
    width: 100% !important;
    height: 60px !important;
    margin-top: 18px !important;
    border: 0 !important;
    border-radius: 18px !important;
    color: white !important;
    background: linear-gradient(135deg, #2563eb, #06b6d4) !important;
    box-shadow: 0 18px 36px rgba(37,99,235,.26) !important;
    font-size: 18px !important;
    font-weight: 900 !important;
}

.m2-login-logo {
    position: absolute;
    left: 50%;
    top: 34px;
    transform: translateX(-50%);
    width: 340px;
    height: 92px;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    z-index: 5;
    pointer-events: none;
    user-select: none;
}

.m2-login-logo-inner {
    display: flex;
    align-items: center;
    justify-content: center;
    line-height: 1;
}

.m2-login-letter {
    display: inline-block;
    font-size: 72px;
    font-weight: 900;
    line-height: 1;
    letter-spacing: -3px;
    animation: m2-login-jump 1.55s ease-in-out infinite;
}

.m2-login-gap {
    width: 18px;
    display: inline-block;
}

.m2-login-letter[data-i="0"] { animation-delay: 0s; }
.m2-login-letter[data-i="1"] { animation-delay: .16s; }
.m2-login-letter[data-i="2"] { animation-delay: .32s; }
.m2-login-letter[data-i="3"] { animation-delay: .48s; }

@keyframes m2-login-jump {
    0% { transform: translate(0, 0) scale(1); }
    18% { transform: translate(-7px, -18px) scale(1.04); }
    34% { transform: translate(6px, 8px) scale(.99); }
    50% { transform: translate(9px, -26px) scale(1.07); }
    66% { transform: translate(-8px, 6px) scale(1); }
    82% { transform: translate(5px, -12px) scale(1.03); }
    100% { transform: translate(0, 0) scale(1); }
}
</style>

<script>
(function () {
    function shuffle(arr) {
        var a = arr.slice();
        for (var i = a.length - 1; i > 0; i--) {
            var j = Math.floor(Math.random() * (i + 1));
            var t = a[i];
            a[i] = a[j];
            a[j] = t;
        }
        return a;
    }

    function insertLogo() {
        var form = document.querySelector("form");
        if (!form || document.querySelector(".m2-login-logo")) return;

        var logo = document.createElement("div");
        logo.className = "m2-login-logo";
        logo.innerHTML =
            '<div class="m2-login-logo-inner">' +
                '<span class="m2-login-letter" data-i="0">Z</span>' +
                '<span class="m2-login-letter" data-i="1">N</span>' +
                '<span class="m2-login-gap"></span>' +
                '<span class="m2-login-letter" data-i="2">M</span>' +
                '<span class="m2-login-letter" data-i="3">2</span>' +
            '</div>';

        form.appendChild(logo);
    }

    function startColor() {
        var letters = Array.prototype.slice.call(document.querySelectorAll(".m2-login-letter"));
        if (!letters.length) return;

        var palette = [
            "#2563eb", "#10b981", "#f59e0b", "#fb7185",
            "#8b5cf6", "#06b6d4", "#ef4444", "#14b8a6",
            "#a855f7", "#84cc16", "#f97316", "#0ea5e9"
        ];

        function recolor() {
            var picked = shuffle(palette).slice(0, letters.length);
            letters.forEach(function (el, idx) {
                el.style.color = picked[idx];
                el.style.textShadow = "0 12px 30px " + picked[idx] + "33";
            });
        }

        recolor();
        setInterval(recolor, 850);
    }

    function init() {
        insertLogo();
        startColor();
        setTimeout(function () {
            var p = document.querySelector('input[type="password"], input[name="luci_password"]');
            if (p) p.focus();
        }, 300);
    }

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", init);
    } else {
        init();
    }
})();
</script>
EOF

cat > "$THEME_DIR/root/etc/uci-defaults/99-m2aurora-theme" <<'EOF'
#!/bin/sh

uci -q set luci.main.mediaurlbase='/luci-static/m2aurora'
uci -q commit luci

rm -rf /tmp/luci-indexcache /tmp/luci-modulecache /tmp/luci-*cache* 2>/dev/null || true

exit 0
EOF

chmod +x "$THEME_DIR/root/etc/uci-defaults/99-m2aurora-theme"

echo "==== luci-theme-m2aurora created ===="
