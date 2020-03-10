$version = Get-Content -Path ./VERSION -Raw

& git.exe tag v$($version.Trim())
