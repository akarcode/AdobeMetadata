

#$AdobeFile = $PSScriptRoot + '\Testfiles\xmp_photoshop.xml'
$AdobeFile = $PSScriptRoot + '\Testfiles\xmp_cases.xml'
$ExifTool = 'C:\Program Files\exiftool\exiftool.exe'


Import-Module -Name ($PSScriptRoot + '\ModulesXMP\ModulesXMP.psd1') -Force -DisableNameChecking


$AdobeMetadata = Get-AdobeMetadata -AdobeFile $AdobeFile -ExifTool $ExifTool

List-AdobeMetadata $AdobeMetadata


<#
$AdobeMetaData['Basic']['CreatorTool']
$AdobeMetaData['Basic']['DateandTimeZone']
$AdobeMetaData['IPTCExtension']['EditedPropertyIPTC']
$AdobeMetaData['MediaManagement']['DocumentID']
#>

