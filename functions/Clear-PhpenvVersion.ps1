<#
.SYNOPSIS
Clears either current local or current global php version depending on parameter -Local or -Global.

.DESCRIPTION
None

.PARAMETER Global
Whenever to clear global php version.

.PARAMETER Local
Whenever to clear local php version.

.NOTES
None

.INPUTS
None

.OUTPUTS
None
#>
function Clear-PhpenvVersion
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position=0, ParameterSetName = "global")]
        [switch]$Global = $False,
        [Parameter(Mandatory = $true, Position=0, ParameterSetName = "local")]
        [switch]$Local = $False
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    Write-Verbose "Unsetting version"

    if ($Local) {
        $file = Get-PhpenvLocalVersionFile
        if ([System.IO.File]::Exists($file)) {
            Write-Verbose "Removing version file at $($file)."
            Remove-Item -Path $file
        }
    }

    if ($Global) {
        Write-Verbose "Resetting global version fille $(Get-PhpenvGlobalVersionFile)"
        "system" | Set-Content (Get-PhpenvGlobalVersionFile)
    }

}