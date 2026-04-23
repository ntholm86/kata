$c = [System.Collections.ArrayList](Get-Content C:\Users\admin\.copilot\skills\SCORECARD.md -Encoding utf8)
$idx76 = -1; $idx77 = -1; $idx78 = -1; $idx79 = -1
for ($i=0; $i -lt 150; $i++) {
  if ($c[$i] -match '^\|\s*76\s*\|') { $idx76 = $i }
  if ($c[$i] -match '^\|\s*77\s*\|') { $idx77 = $i }
  if ($c[$i] -match '^\|\s*78\s*\|') { $idx78 = $i }
  if ($c[$i] -match '^\|\s*79\s*\|') { $idx79 = $i }
}
if ($idx76 -ne -1 -and $idx79 -ne -1) {
  $tmp76 = $c[$idx76]; $tmp77 = $c[$idx77]
  $tmp78 = $c[$idx78]; $tmp79 = $c[$idx79]
  $min = 83 # assume row starts around 83
  $c[$min] = $tmp76
  $c[$min+1] = $tmp77
  $c[$min+2] = $tmp78
  $c[$min+3] = $tmp79
  $c | Set-Content C:\Users\admin\.copilot\skills\SCORECARD.md -Encoding utf8
  Write-Host "Swapped starting at $min"
} else {
  Write-Host "Not found"
}