# Adobe XMP Metadata reader
![screenshot_adobe_metadata](https://github.com/user-attachments/assets/aee791c2-aaae-4d47-9864-a533b96f0c6b)


## **Get-AdobeMetaData**
The functions can be used for Adobe automation. This will either grab the XMP data directly or utilize ExifTool to grab it. The Data is stored in a HashArray.

**$AdobeMetadata = Get-AdobeMetadata -AdobeFile $AdobeFile -ExifTool $ExifTool**

After running the function any parameter can be read from the $AdobeMetadata variable:
- For a category: **$AdobeMetaData['Basic']**
- A specific value: **$AdobeMetaData['Basic']['CreatorTool']**

Two options are available
- To output the XMP data: **OutputXMP**<br/>**$AdobeMetadata = Get-AdobeMetadata -AdobeFile $AdobeFile -ExifTool $ExifTool -OutputXMP**
- To output a formatted text file: **OutputTXT**
**$AdobeMetadata = Get-AdobeMetadata -AdobeFile $AdobeFile -ExifTool $ExifTool -OutputTXT**
They can be used together.

## **List-AdobeMetadata**
This will list the collected Metadata and can be used to save the metadata to a text file.
**List-AdobeMetadata $AdobeMetadata**

Two options are available
- To silence the log output: **Quiet**
**List-AdobeMetadata -Quiet**
- To capture the formatted metadata **Output**
**$FormattedMetadata = List-AdobeMetadata $AdobeMetadata -Output**


## **TestFiles**
I've included two testfiles.
- **xmp_photoshop.xml** this is all the properties found in Photoshop **File>File Info...**.
- **xmp_cases** this is all different XMP structures that i came across. There are most probably more but i don't know.


## **Additional Notes**
- Adobe Premiere (*.prproj) does not have XMP data stored. 'prproj' files are *.zip files.
- After Effects (*.aep) has XMP info stored in the Binary. ExifTool fails to grab it for some reason. Trimmin it out of the Binary does not always work.
- Adobe InDesign (*.idml) is also a *.zip file. The XMP data is directly opened from within the file.
- XMP/XML files can be read directly and then parsed. If **-OutputXMP** is used it will be ignored to avoid overwriting the input.


## **Dependencies**
You'll need ExifTool by Phil Harvey to read out the XMP Metadata.


## Changelog

v1.0 (initial release)