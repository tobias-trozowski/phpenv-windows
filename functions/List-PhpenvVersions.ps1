<#
.SYNOPSIS
None

.DESCRIPTION
None

.NOTES
None

.INPUTS
None

.OUTPUTS
None
#>
function List-PhpenvVersions
{
    [CmdletBinding()]
    param ()
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    $dir = Get-PhpenvVersionDir
    if (!(Test-Path($dir)))
    {
        Write-Verbose "no versions found in $($dir)."
        Write-Host "no versions installed."
        return
    }

    [version[]]$Versions = @()
    $DirList = Get-ChildItem -Path $dir -Directory
    foreach ($Version in $DirList)
    {
        Write-Verbose "Found version $( $Version.Name )"
        $Versions += [version]::New("$( $Version.Name )")
    }

    if ($Version.Count -eq 0) {
        Write-Verbose "no versions found in $($dir)."
        Write-Host "no versions installed."
        return
    }

    return $Versions
}