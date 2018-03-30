<#
.SYNOPSIS
Returns either current local or current global php version depending on parameter -Local or -Global.

.DESCRIPTION
None

.PARAMETER Global
Whenever to return global php version. If no global version is set 'system' is returned by default.

.PARAMETER Local
Whenever to return local php version. Ignored if -Global is set.

.NOTES
None

.INPUTS
None

.OUTPUTS
None
#>
function Get-PhpenvVersion
{
    [CmdletBinding()]
    param (
        [switch]$Global = $false,
        [switch]$Local = $false
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    if ($Local)
    {
        $Version = Get-PhpenvLocalVersion
        if ($Version -eq $NULL)
        {
            Write-Host "no local version configured for this directory"
        }
        return $Version
    }
    elseif ($Global)
    {
        return Get-PhpenvGlobalVersion
    }

    $Version = Get-PhpenvLocalVersion
    if ($Version -eq $NULL)
    {
        return Get-PhpenvGlobalVersion
    }

    return $Version
}