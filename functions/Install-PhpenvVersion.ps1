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
function Install-PhpenvVersion
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = "PHP version to install.")]
        [version]$Version,
        [Parameter(Position = 1, HelpMessage = "PHP version to install.")]
        [Alias("NTS")]
        [switch]$NonThreadSafe = $False,
        [Parameter(Position = 2, HelpMessage = "PHP version to install.")]
        [Alias("E")]
        [string]$Environment
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    $targetPath = "$( Get-PhpenvVersionDir $Version )"
    if (Test-Path("$( $targetPath )\php.exe"))
    {
        Write-Host "Version $( $Version ) already installed."
        return
    }

    $useX64 = $False

    $url = (Get-PhpDownloadUrl $Version $useX64 $NonThreadSafe);
    Write-Verbose "Checking availability of version $( $Version ) from $( $url )."
    if (!(UrlExists $url))
    {
        Write-Verbose "Unable to find downloadable version at $( $url )."
        $url = (Get-PhpDownloadUrl $Version $useX64 $NonThreadSafe $true)
        Write-Verbose "Checking availability of version $( $Version ) from $( $url )."
        if (!(UrlExists $url))
        {
            Write-Verbose "Unable to find downloadable version at $( $url )."
            Write-Host "Unable to install version $( $Version )."
            return
        }
    }

    $tempDir = Join-Path $env:TEMP "phpenv"
    if (![System.IO.Directory]::Exists($tempDir))
    {
        [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null
    }
    $downloadFilePath = Join-Path $tempDir "$( $Version )Install.zip"
    Write-Verbose "Downloading $( $url ) to $( $downloadFilePath )"
    try
    {
        $wc = New-Object System.Net.WebClient
        $wc.Headers.Add("user-agent", "Windows-PHPEnv/1.0")

        Write-Verbose "Request Headers:"
        foreach ($key in $wc.Headers)
        {
            $value = $wc.Headers[$key];
            if ($value)
            {
                Write-Debug "  `'$key`':`'$value`'"
            }
            else
            {
                Write-Debug "  `'$key`'"
            }
        }

        Write-Verbose "Starting download of $($url)"
        $wc.DownloadFile($url, $downloadFilePath)
        $phpenvHome = Get-PhpenvHome
        Unzip $downloadFilePath "$( Get-PhpenvVersionDir $Version )"
        Remove-Item -Path $downloadFilePath
    }
    catch
    {
        if ($_.Exception.Response.StatusCode.Value__ -eq 404)
        {
            Write-Error "Unable to find package for version $( $Version )"
            return
        }
        Write-Error "Failed to download package for version $( $Version ). Please try again later."
        return
    }
}
