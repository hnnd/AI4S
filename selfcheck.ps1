# Environment self-check for the textbook (2nd ed., Appendix A.6):
# "LLMs and Research Agents: A Practical Guide for Agricultural and Life Science Research" (Windows PowerShell version)
# Checks 5 items: node >= 18, npm, opencode (1.x or 2.x; 2.x recommended), python3, network to api.deepseek.com
# Output is in English on purpose (avoids CJK garbling in the Windows console).
# Run with:  powershell -ExecutionPolicy Bypass -File .\selfcheck.ps1

$Pass = 0
$Total = 5

Write-Host "=============================================="
Write-Host " Textbook Environment Self-Check (Windows)"
Write-Host "=============================================="
Write-Host ""

# --- Check 1: Node.js version >= 18 ---
$nodeCmd = Get-Command node -ErrorAction SilentlyContinue
if ($nodeCmd) {
    $nodeVer = (& node -v) 2>$null          # e.g. v24.x.x
    $major = 0
    if ($nodeVer -match '^v(\d+)\.') { $major = [int]$Matches[1] }
    if ($major -ge 18) {
        Write-Host "[OK]   Node.js $nodeVer (need >= v18)"
        $Pass++
    } else {
        Write-Host "[FAIL] Node.js found but version is $nodeVer (need >= v18)."
        Write-Host "       Fix: reinstall Node.js LTS -- see Appendix A.2."
    }
} else {
    Write-Host "[FAIL] Node.js not found."
    Write-Host "       Fix: install Node.js LTS -- see Appendix A.2."
    Write-Host "       (If you just installed it, close this window and open a NEW PowerShell.)"
}

# --- Check 2: npm available ---
$npmCmd = Get-Command npm -ErrorAction SilentlyContinue
if ($npmCmd) {
    $npmVer = (& cmd /c "npm -v") 2>$null
    Write-Host "[OK]   npm $npmVer"
    $Pass++
} else {
    Write-Host "[FAIL] npm not found (it normally ships with Node.js)."
    Write-Host "       Fix: reinstall Node.js LTS -- see Appendix A.2."
}

# --- Check 3: opencode installed, major version 1.x or 2.x (2.x recommended) ---
# 1.x prints a bare version ("1.18.34"); 2.x prints "opencode v2.0.22".
$ocCmd = Get-Command opencode -ErrorAction SilentlyContinue
if ($ocCmd) {
    $ocVer = (& cmd /c "opencode --version") 2>$null | Select-Object -First 1
    if ("$ocVer" -match '^(opencode )?v?2\.') {
        Write-Host "[OK]   opencode version: $ocVer (2.x, recommended)"
        $Pass++
    } elseif ("$ocVer" -match '^(opencode )?v?1\.') {
        Write-Host "[OK]   opencode version: $ocVer (1.x, supported; 2.x recommended)"
        $Pass++
    } else {
        Write-Host "[WARN] opencode found but version is '$ocVer' (expected 1.x or 2.x)."
        Write-Host "       Fix: run 'npm install -g @opencode/cli' -- then check 'opencode --version' as in Appendix A.2."
    }
} else {
    Write-Host "[FAIL] opencode command not found."
    Write-Host "       Fix: run 'npm install -g @opencode/cli' -- then check 'opencode --version' as in Appendix A.2."
}

# --- Check 4: Python 3 available ---
# Try 'python' first (the usual name on Windows), then 'python3'.
$pyOk = $false
foreach ($pyName in @('python', 'python3')) {
    if ($pyOk) { break }
    $pyCmd = Get-Command $pyName -ErrorAction SilentlyContinue
    if ($pyCmd) {
        $pyVer = (& $pyName --version) 2>&1 | Out-String
        if ($pyVer -match 'Python 3') {
            Write-Host ("[OK]   " + $pyVer.Trim() + " (via '$pyName')")
            $Pass++
            $pyOk = $true
        }
    }
}
if (-not $pyOk) {
    Write-Host "[FAIL] Python 3 not found (or the Microsoft Store alias intercepted it)."
    Write-Host "       Fix: install Python 3 and tick 'Add python.exe to PATH' -- see Appendix A.2."
}

# --- Check 5: network reachability of api.deepseek.com (no API key needed) ---
# Any HTTP status (even 401/404) proves the network path works.
$netOk = $false
try {
    $resp = Invoke-WebRequest -Uri "https://api.deepseek.com" -Method Head -TimeoutSec 10 -UseBasicParsing -ErrorAction Stop
    if ($resp.StatusCode) { $netOk = $true; $code = $resp.StatusCode }
} catch {
    if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
        $netOk = $true
        $code = [int]$_.Exception.Response.StatusCode
    }
}
if ($netOk) {
    Write-Host "[OK]   api.deepseek.com is reachable (HTTP $code)"
    $Pass++
} else {
    Write-Host "[FAIL] Cannot reach api.deepseek.com."
    Write-Host "       Fix: check your network (try phone hotspot) -- see Appendix B."
}

Write-Host ""
Write-Host "----------------------------------------------"
Write-Host " Result: $Pass/$Total checks passed."
if ($Pass -eq $Total) {
    Write-Host " All checks passed. Your environment is ready."
} else {
    Write-Host " Some checks failed. Follow the fix hints above,"
    Write-Host " or paste the full output to an agent (see Appendix A.6)."
}
Write-Host "----------------------------------------------"
