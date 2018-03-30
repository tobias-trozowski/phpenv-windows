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
function Set-PhpenvHome
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = "Phpenv home directory.")]
        [string]$Home
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    Write-Verbose "Set environment 'PHPENV_HOME' to '$($Home)'."
    [Environment]::SetEnvironmentVariable("PHPENV_HOME", (Get-Module -ListAvailable phpenv).path$Home, "User")
}
