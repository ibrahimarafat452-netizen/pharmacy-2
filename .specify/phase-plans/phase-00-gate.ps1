# Phase 0 acceptance gate.
# Exit codes: 0 = documents pass and owner approval is recorded;
#             1 = a document check failed;
#             2 = document checks pass, but owner approval is not yet recorded in spec.md.
param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
)
$ErrorActionPreference = 'Stop'
$fail = $false
$dir = Join-Path $Root 'specs\001-requirements-risk-closure'
$spec = Join-Path $dir 'spec.md'
if (-not (Test-Path $spec)) { Write-Output "FAIL: missing $spec"; exit 1 }
foreach ($name in 'risk-register.md', 'constitution-checklist.md') {
    if (-not (Test-Path (Join-Path $dir $name))) { Write-Output "FAIL: missing $dir\$name"; $fail = $true }
}

# Markers are matched across the whole file: any case, any whitespace or line break between the
# two words, and '_' or '-' as separators, so wrapped or reformatted markers are still caught.
$marker = [regex]'(?i)NEEDS[\s_-]+CLARIFICATION'
foreach ($file in Get-ChildItem -Path $dir -Filter *.md -Recurse) {
    $text = [System.IO.File]::ReadAllText($file.FullName)
    foreach ($m in $marker.Matches($text)) {
        $line = $text.Substring(0, $m.Index).Split("`n").Count
        Write-Output "FAIL: unresolved marker at $($file.FullName):$line"
        $fail = $true
    }
}

# Each article needs its own heading, not merely a mention such as "Article I-XIII".
$cl = Join-Path $dir 'constitution-checklist.md'
if (Test-Path $cl) {
    $clText = [System.IO.File]::ReadAllText($cl)
    foreach ($roman in 'I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII') {
        if ($clText -notmatch "(?m)^#{2,}\s+Article\s+$roman\b") {
            Write-Output "FAIL: constitution-checklist.md has no heading for Article $roman"; $fail = $true
        }
    }
}
if ($fail) { exit 1 }
Write-Output 'PASS (documents): Phase 0 deliverables present, no open clarification markers, all 13 articles have entries'

# Acceptance also requires the owner's recorded approval (spec.md User Story 1, FR-008, SC-005).
$specText = [System.IO.File]::ReadAllText($spec)
if ($specText -notmatch '(?m)^\*\*Status\*\*:\s*Approved\b.*\d{4}-\d{2}-\d{2}') {
    Write-Output 'PENDING: owner approval is not recorded (spec.md Status must read "Approved" with a date)'
    exit 2
}
Write-Output 'PASS: owner approval recorded'
exit 0
