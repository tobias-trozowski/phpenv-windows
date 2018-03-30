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
function Get-PhpenvHome
{
    [CmdletBinding()]
    param()
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    if ($env:PHPENV_HOME -eq '' -or $env:PHPENV_HOME -eq $NULL)
    {
        Write-Verbose "PHPENV_HOME environment variable not set. Using default location '$( $env:USERPROFILE )\.phpenv'"
        return "$( $env:USERPROFILE )\.phpenv"
    }
    return $env:PHPENV_HOME
}