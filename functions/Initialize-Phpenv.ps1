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
function Initialize-Phpenv
{
    [CmdletBinding()]
    param()
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    Write-Verbose "Initializing phpenv..."

    $path = Get-PhpenvHome
    if (![System.IO.Directory]::Exists($path)) {
        Write-Verbose "Phpenv home not exist. Creating new home at $($path)."
        [System.IO.Directory]::CreateDirectory($path) | Out-Null
    }
}
