function UrlExists() {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$uri
    )
    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    try {
        Write-Verbose "Invoking HEAD request to $($uri)."
        Invoke-Webrequest -uri $uri -Method HEAD
    } catch {
        Write-Verbose "Server returned status $($_.Exception.Response.StatusCode.Value__) for $($uri)."
        if ($_.Exception.Response.StatusCode.Value__ -eq 404) { return $false }
    }

    return $true;
}