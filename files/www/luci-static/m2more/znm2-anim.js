(function () {
  function sanitizeText(s) {
    return String(s || "")
      .replace(/\u0000/g, "")
      .replace(/\s+/g, " ")
      .trim();
  }

  function normalizeDeviceName(model) {
    var raw = sanitizeText(model);

    if (!raw || raw === "--") {
      return "OPENWRT";
    }

    var rules = [
      { re: /link[_ -]?nn6000.*v1|nn6000.*v1/i, name: "NN6000 V1" },
      { re: /zn[-_ ]?m2|zn_m2/i, name: "ZN M2" },
      { re: /redmi.*ax6/i, name: "AX6" },
      { re: /redmi.*ax5/i, name: "AX5" },
      { re: /x86|generic/i, name: "X86" }
    ];

    for (var i = 0; i < rules.length; i++) {
      if (rules[i].re.test(raw)) {
        return rules[i].name;
      }
    }

    return raw
      .replace(/^friendlyarm\s+/i, "")
      .replace(/^xiaomi\s+/i, "")
      .replace(/^redmi\s+/i, "")
      .replace(/^openwrt\s+/i, "")
      .trim()
      .toUpperCase();
  }

  function findLogoElement() {
    return document.querySelector(".hero h1") ||
           document.querySelector(".m2more h1") ||
           document.querySelector("h1");
  }

  function renderDeviceLogo(model) {
    var el = findLogoElement();
    if (!el) return;

    var name = normalizeDeviceName(model);

    el.classList.add("device-model-logo");
    el.innerHTML = "";

    name.split("").forEach(function (ch) {
      var span = document.createElement("span");

      if (ch === " ") {
        span.className = "device-logo-space";
        span.innerHTML = "&nbsp;";
      } else {
        span.className = "znm2-letter device-logo-letter";
        span.textContent = ch;
      }

      el.appendChild(span);
    });
  }

  var colors = [
    "#2563eb",
    "#10b981",
    "#f59e0b",
    "#fb7185",
    "#8b5cf6",
    "#06b6d4",
    "#ef4444",
    "#84cc16"
  ];

  function recolor() {
    var letters = document.querySelectorAll(".znm2-letter");

    letters.forEach(function (el, index) {
      el.style.color = colors[index % colors.length];
    });
  }

  function updateLogo() {
    fetch("/cgi-bin/luci/admin/status/m2more/data?_=" + Date.now(), {
      credentials: "same-origin",
      cache: "no-store"
    })
      .then(function (r) {
        return r.json();
      })
      .then(function (d) {
        renderDeviceLogo(d.display_model || d.model || d.hostname || "OPENWRT");
        recolor();
      })
      .catch(function () {
        recolor();
      });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", updateLogo);
  } else {
    updateLogo();
  }
})();
