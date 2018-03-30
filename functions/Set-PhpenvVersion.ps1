<#
.SYNOPSIS
Set either current local or current global php version depending on parameter -Local or -Global.

.DESCRIPTION
None

.PARAMETER Global
Whenever to set global php version.

.PARAMETER Local
Whenever to set local php version.

.PARAMETER Version
The specific php version to set.

.NOTES
None

.INPUTS
None

.OUTPUTS
Error if specified version is not installed.
#>
function Set-PhpenvVersion
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position=0, ParameterSetName = "global")]
        [switch]$Global = $False,
        [Parameter(Mandatory = $true, Position=0, ParameterSetName = "local")]
        [switch]$Local = $False,
        [Parameter(Mandatory = $true, Position=1)]
        [version]$Version
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    Write-Verbose "Setting local version to $($Version)"

    $versions = List-PhpenvVersions
    if (-Not $null -ne ($versions | ? { $Version -match $_ })) {
        Write-Error "Version $($Version) is not installed."
        return
    }

    if ($Local) {
        Write-Verbose "Writing $($Version) to $(Get-PhpenvDefaultLocalVersionFile)"
        "$($Version)" | Set-Content (Get-PhpenvDefaultLocalVersionFile)
    }

    if ($Global) {
        Write-Verbose "Writing $($Version) to $(Get-PhpenvDefaultGlobalVersionFile)"
        "$($Version)" | Set-Content (Get-PhpenvDefaultGlobalVersionFile)
    }
}