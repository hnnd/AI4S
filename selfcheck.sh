#!/usr/bin/env bash
# Environment self-check for the textbook (2nd ed., Appendix A.6):
# "LLMs and Research Agents: A Practical Guide for Agricultural and Life Science Research" (macOS / Linux version)
# Checks 5 items: node >= 18, npm, opencode (1.x or 2.x; 2.x recommended), python3, network to api.deepseek.com
# Output is in English on purpose (avoids CJK garbling in some terminals).

PASS=0
TOTAL=5

echo "=============================================="
echo " Textbook Environment Self-Check (mac/Linux)"
echo "=============================================="
echo ""

# --- Check 1: Node.js version >= 18 ---
if command -v node >/dev/null 2>&1; then
    NODE_VER_RAW="$(node -v 2>/dev/null)"                # e.g. v24.x.x
    NODE_MAJOR="$(echo "$NODE_VER_RAW" | sed 's/^v//' | cut -d. -f1)"
    if [ -n "$NODE_MAJOR" ] && [ "$NODE_MAJOR" -ge 18 ] 2>/dev/null; then
        echo "[OK]   Node.js $NODE_VER_RAW (need >= v18)"
        PASS=$((PASS + 1))
    else
        echo "[FAIL] Node.js found but version is $NODE_VER_RAW (need >= v18)."
        echo "       Fix: reinstall Node.js LTS -- see Appendix A.2."
    fi
else
    echo "[FAIL] Node.js not found."
    echo "       Fix: install Node.js LTS -- see Appendix A.2."
fi

# --- Check 2: npm available ---
if command -v npm >/dev/null 2>&1; then
    echo "[OK]   npm $(npm -v 2>/dev/null)"
    PASS=$((PASS + 1))
else
    echo "[FAIL] npm not found (it normally ships with Node.js)."
    echo "       Fix: reinstall Node.js LTS -- see Appendix A.2."
fi

# --- Check 3: opencode installed, major version 1.x or 2.x (2.x recommended) ---
# 1.x prints a bare version ("1.18.34"); 2.x prints "opencode v2.0.22".
if command -v opencode >/dev/null 2>&1; then
    OC_VER="$(opencode --version 2>/dev/null | head -n 1)"
    case "$OC_VER" in
        2.*|v2.*|"opencode v2."*)
            echo "[OK]   opencode version: $OC_VER (2.x, recommended)"
            PASS=$((PASS + 1))
            ;;
        1.*|v1.*|"opencode v1."*)
            echo "[OK]   opencode version: $OC_VER (1.x, supported; 2.x recommended)"
            PASS=$((PASS + 1))
            ;;
        *)
            echo "[WARN] opencode found but version is '$OC_VER' (expected 1.x or 2.x)."
            echo "       Fix: run 'npm install -g @opencode/cli' -- then check 'opencode --version' as in Appendix A.2."
            ;;
    esac
else
    echo "[FAIL] opencode command not found."
    echo "       Fix: run 'npm install -g @opencode/cli' -- then check 'opencode --version' as in Appendix A.2."
fi

# --- Check 4: python3 available ---
if command -v python3 >/dev/null 2>&1; then
    echo "[OK]   $(python3 --version 2>&1)"
    PASS=$((PASS + 1))
elif command -v python >/dev/null 2>&1 && python --version 2>&1 | grep -q "Python 3"; then
    echo "[OK]   $(python --version 2>&1) (via 'python')"
    PASS=$((PASS + 1))
else
    echo "[FAIL] Python 3 not found."
    echo "       Fix: install Python 3 -- see Appendix A.2."
fi

# --- Check 5: network reachability of api.deepseek.com (no API key needed) ---
# Any HTTP response code (even 401/404) proves the network path works.
if command -v curl >/dev/null 2>&1; then
    HTTP_CODE="$(curl -s -o /dev/null -w '%{http_code}' --connect-timeout 10 https://api.deepseek.com 2>/dev/null)"
    if [ -n "$HTTP_CODE" ] && [ "$HTTP_CODE" != "000" ]; then
        echo "[OK]   api.deepseek.com is reachable (HTTP $HTTP_CODE)"
        PASS=$((PASS + 1))
    else
        echo "[FAIL] Cannot reach api.deepseek.com."
        echo "       Fix: check your network (try phone hotspot) -- see Appendix B."
    fi
else
    echo "[FAIL] curl not found, cannot test network."
    echo "       Fix: on macOS curl is built in -- see Appendix B."
fi

echo ""
echo "----------------------------------------------"
echo " Result: $PASS/$TOTAL checks passed."
if [ "$PASS" -eq "$TOTAL" ]; then
    echo " All checks passed. Your environment is ready."
else
    echo " Some checks failed. Follow the fix hints above,"
    echo " or paste the full output to an agent (see Appendix A.6)."
fi
echo "----------------------------------------------"
