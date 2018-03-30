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
function Invoke-Phpenv
{
    [CmdletBinding()]
    Param (
        [parameter(ValueFromRemainingArguments = $true)]
        [Object[]]$phpArgs
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    $bin = "php"
    $version = Get-PhpenvVersion
    if ($version -ne "system")
    {
        $bin = Get-PhpenvPHPExecutable (Get-PhpenvVersion)
    }

    & $bin @phpArgs
    #    Invoke-Expression [string]@execArgs
}