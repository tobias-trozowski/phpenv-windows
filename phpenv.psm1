
if (Get-Module phpenv) { return }

$thisDirectory = (Split-Path -parent $MyInvocation.MyCommand.Definition)
Write-Verbose "Going to import all scripts from $($thisDirectory)\lib"
$helpers  = @( Get-ChildItem -Path $thisDirectory\lib\*.ps1 -ErrorAction SilentlyContinue )
Foreach($helper in $helpers)
{
    Try
    {
        Write-Verbose "Try to import $($helper.FullName)."
        . $helper.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($helper.fullname): $_"
    }
}


Write-Verbose "Going to import all functions from $($thisDirectory)\functions"
$imports  = @( Get-ChildItem -Path $thisDirectory\functions\*.ps1 -ErrorAction SilentlyContinue )
Foreach($import in $imports)
{
    Try
    {
        Write-Verbose "Try to import $($import.FullName)."
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# Here I might...
    # Read in or create an initial config file and variable
    # Export Public functions ($Public.BaseName) for WIP modules
    # Set variables visible to the module and its functions only

# Export-ModuleMember -Function $Public.Basename
# Export-ModuleMember -Function * -Alias * -Cmdlet *
Export-ModuleMember -Function * -Alias * -Cmdlet *