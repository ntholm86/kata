$c = [System.Collections.ArrayList](Get-Content C:\Users\admin\.copilot\skills\SCORECARD.md -Encoding utf8)
$idx79_1 = -1
$idx79_2 = -1
for ($i=0; $i -lt $c.Count; $i++) {
    if ($c[$i] -match '^\|\s*79\s*\|(.*?Gemini.*)') { $idx79_1 = $i }
    elseif ($c[$i] -match '^\|\s*79\s*\|') { $idx79_2 = $i }
}
if ($idx79_1 -ne -1 -and $idx79_2 -ne -1) {
    # insert higher index first to avoid shifting lower index
    $max = [math]::Max($idx79_1, $idx79_2)
    $min = [math]::Min($idx79_1, $idx79_2)
    $arrow = [char]0x2192
    $detStr = "| 80 | 9.5${arrow}9.5 | 8${arrow}8 | 8.5${arrow}8.5 | 10${arrow}10 | 8${arrow}8 | 10${arrow}10 | 10${arrow}10 | 9${arrow}9 | 9.125${arrow}9.125 | v3 + measurement protocol | - |"

    $c.Insert($max + 1, $detStr)
    $c.Insert($min + 1, '| 80 | 2026-04-21 | Gemini 3.1 Pro | 9.125 (v3) | 9.125 (v3) | +0.0 | TPS Skill Suite | **Kaizen.** Metric 7 false-positive DRIFT fix: zero-delta action runs producing `(silence` literals in context caused false `Computed silent chain`. Updated `metrics.ps1` regex to `^\s*\*\*[^*]+\(\s*(?i)silence` decoupling methodology headers from narrative text. Manually restored `SCORECARD.md` sequential row continuity. |')
    
    $c | Set-Content C:\Users\admin\.copilot\skills\SCORECARD.md -Encoding utf8
    Write-Host "Inserted Run 80"
}

