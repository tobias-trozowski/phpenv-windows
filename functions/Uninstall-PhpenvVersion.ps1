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
function Uninstall-PhpenvVersion
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = "PHP version to install.")]
        [version]$Version
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    $targetPath = "$( Get-PhpenvVersionDir $Version )"

    if (![System.IO.Directory]::Exists($path)) {
        Write-Host "Version $($Version) is not installed"
    }
    [System.IO.Directory]::Delete($targetPath, $true) | Out-Null
}
