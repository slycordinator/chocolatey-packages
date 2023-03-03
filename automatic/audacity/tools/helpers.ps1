function Get-MergeTasks([hashtable] $pp) {
    $tasks = @()
    $tasks += '!'* $pp.NoDesktopIcon     + 'desktopicon'

    Write-Host "Merge Tasks: $tasks"
    return $tasks -join ','
}
