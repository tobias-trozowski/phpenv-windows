function Get-VCVersionForPhpVersion {

    param(
        [Parameter(Mandatory=$true, Position=0)]
        [version]$Version,
        [Parameter(Mandatory=$False, Position=1)]
        [switch]$x86=$False,
        [Parameter(Mandatory=$False, Position=2)]
        [switch]$NTS=$False
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    $VCVersion="VC6"
    if ($Version.CompareTo([version]"5.3") -ge 0) {
        $VCVersion="VC9"
    }
    if ($Version.CompareTo([version]"5.5") -ge 0) {
        $VCVersion="VC11"
    }
    if ($Version.CompareTo([version]"7.0") -ge 0) {
        $VCVersion="VC14"
    }
    if ($Version.CompareTo([version]"7.2") -ge 0) {
        $VCVersion="VC15"
    }

    return $VCVersion
}