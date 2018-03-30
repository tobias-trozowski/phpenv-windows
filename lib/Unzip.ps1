Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$zipfile,
        [Parameter(Mandatory=$true, Position=1)]
        [string]$outpath
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    Write-Verbose "Extracting $($zipfile) to $($outpath)."
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}