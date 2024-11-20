function Get-AdobeMetadata {

    param (
        [Parameter(Mandatory)][string]$ExifTool,
        [Parameter(Mandatory)][string]$AdobeFile,
        [switch]$OutputXMP,
        [switch]$OutputTXT
    )

    $ExifArgs = '-xmp', '-b', $AdobeFile
    [xml]$XmlData = $XmlDataRaw = ''

    try {
    
        if ([IO.Path]::GetExtension($AdobeFile) -eq '.idml') {

            Add-Type -AssemblyName System.IO.Compression.FileSystem

            $ZipData = [IO.Compression.ZipFile]::OpenRead($AdobeFile).GetEntry('META-INF/metadata.xml')
            $StreamReader = [IO.StreamReader]::New($ZipData.Open())

            try {
            
                [xml]$XmlData = $XmlDataRaw = $StreamReader.ReadToEnd() -split "`n"
            
            } finally {
            
                $StreamReader.Dispose()
            }
    
        } else {
        
            try {

                [xml]$XmlData = $XmlDataRaw = & $ExifTool $ExifArgs 2>&1
        
            } catch {
            
                # XmlDataRaw is an array at this point!

                $IndexStart = [Array]::IndexOf($XmlDataRaw, ($XmlDataRaw -like "<x:xmpmeta*")[0])
                $IndexEnd = [Array]::IndexOf($XmlDataRaw, ($XmlDataRaw -like '</x:xmpmeta>')[0])

                if ($IndexStart -ne -1 -and $IndexEnd -ne -1) {

                    try {

                        [xml]$XmlData = $XmlDataRaw = $XmlDataRaw[$IndexStart..$IndexEnd]
                    
                    } catch {}
                } else {
                
                    # last resort

                    $Bytes = [IO.File]::ReadAllBytes($AdobeFile)
                    $FileData = [Text.Encoding]::UTF8.GetString($Bytes)

                    $IndexStart = $IndexEnd = -1
                    $IndexStart = $FileData.IndexOf('<x:xmpmeta')
                    $IndexEnd = $FileData.IndexOf('</x:xmpmeta>') + '</x:xmpmeta>'.Length

                    if ($IndexStart -ne -1 -and $IndexEnd -ne -1) {

                        [xml]$XmlData = $XmlDataRaw = $FileData.Substring($IndexStart, $IndexEnd - $IndexStart)

                    }
                }
            }
        }
    } catch {}


    if (!$XmlData.xmpmeta -and !$XmlData.xmpmeta.HasChildNodes) {

        Write-Host 'XMP Data not found!' -ForegroundColor Red

    } else {
        
        if ($OutputXMP -and [IO.Path]::GetExtension($AdobeFile) -ne '.xml') {

            $XmpOutFile = [IO.Path]::ChangeExtension($AdobeFile , 'xml') -replace '.xml$', '_metadata.xml'
            [IO.File]::WriteAllLines($XmpOutFile, $XmlDataRaw)

        }

        $nsManager = New-Object Xml.XmlNamespaceManager($XmlData.NameTable)
        $nsManager.AddNamespace('rdf', 'http://www.w3.org/1999/02/22-rdf-syntax-ns#')

        $DescriptionNodes = $XmlData.SelectNodes("//rdf:Description/*", $nsManager)
        $Collection = [Collections.SortedList]::new()

        foreach ($Node in $DescriptionNodes) {

            $NodeName = $Node.LocalName
            $Category = $Node.Prefix
            $Category = Get-Category -Value $Category
            $SubCategory = $Null

            if (!$Collection.ContainsKey($Category)) {

                $Collection[$Category] = [Collections.SortedList]::new()

            }

            Get-Resource -CurrentNode $Node -SubCategory $SubCategory -NodeName $NodeName

        }


        if ($OutputTXT) {

            $OutputMetaData = List-AdobeMetadata $Collection -Output

            $TextOutFile = [IO.Path]::ChangeExtension($AdobeFile , 'txt') -replace '.txt$', '_metadata.txt'
            [IO.File]::WriteAllLines($TextOutFile, $OutputMetaData)

        }

        return $Collection

    }
}