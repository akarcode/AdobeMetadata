#
# loads all ps1 files and its included functions
#
$ScriptFiles = Get-ChildItem -Path $PSScriptRoot -Filter *.ps1 -ErrorAction SilentlyContinue

ForEach ($ScriptFile in $ScriptFiles) {

    Try {

        . $ScriptFile.FullName

    } Catch {

        Write-Error -Message "Failed to import function $($ScriptFile.FullName): $_"

    }
}

# variable needs specific list or else the variables in this file will be also be imported
Export-ModuleMember -Function * -Variable 'pa*', 'a*'