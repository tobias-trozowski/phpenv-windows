function Get-PhpenvDefaultGlobalVersionFile
{
    [CmdletBinding()]
    param ()
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    return "$( Get-PhpenvHome )\version"
}

function Get-PhpenvDefaultLocalVersionFile
{
    [CmdletBinding()]
    param ()
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    return "$( Get-Location )\.php-version"
}

function Get-PhpenvGlobalVersionFile
{
    [CmdletBinding()]
    param ()
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    $phpenvHome = Get-PhpenvHome
    $VersionFile = Get-PhpenvDefaultGlobalVersionFile

    Write-Verbose "Searching global version file in $( $phpenvHome )"
    if (Test-Path ($VersionFile))
    {
        Write-Verbose "Found global version file at $( $VersionFile )"
        return $VersionFile
    }
    elseif (Test-Path ("$( $phpenvHome )\global"))
    {
        # lookup for 'global' to be compatible with *nix phpenv
        Write-Verbose "Found global version file at $( $phpenvHome )\global"
        return "$( $phpenvHome )\global"
    }
    elseif (Test-Path ("$( $phpenvHome )\default"))
    {
        # lookup for 'default' to be compatible with *nix phpenv
        Write-Verbose "Found global version file at $( $phpenvHome )\default"
        return "$( $phpenvHome )\default"
    }

    return $VersionFile
}

function Get-PhpenvLocalVersionFile
{
    [CmdletBinding()]
    param ()
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    Write-Verbose "Looking up local version file."

    $current = Get-Location
    while ($current -ne '')
    {
        Write-Verbose "Searching local version file in $( $current )"
        if ([System.IO.File]::Exists("$( $current )\.php-version"))
        {
            Write-Verbose "Found local version file at $( $current )\.php-version"
            return "$( $current )\.php-version"
        }
        elseif ([System.IO.File]::Exists("$( $current )\.phpenv-version"))
        {
            # lookup for .phpenv-version to be compatible with *nix phpenv
            Write-Verbose "Found local version file at $( $current )\.phpenv-version"
            return "$( $current )\.phpenv-version"
        }
        $parent = Split-Path -parent $current
        $current = if ($parent -ne $NULL)
        {
            $parent
        }
        else
        {
            ""
        }
    }
    return $NULL
}

function Get-PhpenvGlobalVersion
{
    [CmdletBinding()]
    param ()
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    Write-Verbose "Looking up global php version."

    $file = Get-PhpenvGlobalVersionFile
    if (-Not(Test-Path($file)))
    {
        Write-Verbose "Global version file '$( $file )' not found. Using default 'system'."
        return "system"
    }

    $Version = Get-Content $file
    if ($Version -eq '')
    {
        Write-Verbose "Global version file '$( $file )' is empty. Using default 'system'."
        return "system"
    }

    Write-Verbose "Global version found: '$( $Version )'."
    return $Version
}

function Get-PhpenvLocalVersion
{
    [CmdletBinding()]
    param ()
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    $file = Get-PhpenvLocalVersionFile
    if ($file -eq $NULL)
    {
        return $NULL
    }

    $Version = Get-Content $file
    if ($Version -eq '')
    {
        Write-Verbose "Local version file '$( $file )' is empty."
        return $NULL
    }

    Write-Verbose "Local version found: '$( $Version )'."
    return $Version
}

function Find-PhpenvVersionFile
{
    [CmdletBinding()]
    param ()
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    $file = Get-PhpenvLocalVersionFile
    if ($file -eq '')
    {
        $file = Get-PhpenvGlobalVersionFile
    }
    return $file
}

function Get-PhpenvVersionFile
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Global", HelpMessage = "Returns global php version.")]
        [switch]$Global = $false,
        [Parameter(Mandatory = $true, ParameterSetName = "Local", HelpMessage = "Searches for local php version in tree. Ignored if -Global is set.")]
        [switch]$Local = $false
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    if ($Local)
    {
        $file = Get-PhpenvLocalVersionFile
        if ($file -eq $NULL)
        {
            Write-Host "no local version configured for this directory."
            return
        }
    }
    elseif ($Global)
    {
        $file = Get-PhpenvGlobalVersionFile
    }
    else
    {
        $file = Find-PhpenvVersionFile
    }

    return $file
}

function Get-PhpDownloadFileName
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [version]$Version,
        [Parameter(Mandatory = $False, Position = 1)]
        [switch]$x64 = $False,
        [Parameter(Mandatory = $False, Position = 2)]
        [switch]$NTS = $False
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    $VCVersion = Get-VCVersionForPhpVersion $Version;
    $ntsString = ""
    if ($NTS)
    {
        $ntsString = "-nts"
    }
    $bit = "x86"
    if ($x64)
    {
        $bit = "x64"
    }
    return "php-$( $Version )$( $ntsString )-Win32-$( $VCVersion )-$( $bit ).zip"
}

function Get-PhpDownloadUrl
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [version]$Version,
        [Parameter(Mandatory = $False, Position = 1)]
        [switch]$x64 = $False,
        [Parameter(Mandatory = $False, Position = 2)]
        [switch]$NTS = $False,
        [Parameter(Mandatory = $False, Position = 3)]
        [switch]$Archive = $False
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    return "http://windows.php.net/downloads/releases/" + (&{
        If ($Archive)
        {
            "archives/"
        }
    }) + "$( Get-PhpDownloadFileName $Version $x64 $NTS )"
}

function Get-PhpenvVersionDir
{
    [CmdletBinding()]
    param (
        [version]$Version
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    $path = Join-Path (Get-PhpenvHome) "versions"

    if ($Version)
    {
        return Join-Path $path $Version
    }

    return $path
}

function Get-PhpenvPHPExecutable {
    [CmdletBinding()]
    param (
        [version]$Version
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    return Join-Path (Get-PhpenvVersionDir $Version) "php.exe"
}