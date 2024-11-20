# Adobe XMP Metadata reader
![screenshot_adobe_metadata_2](https://github.com/user-attachments/assets/4a5dc664-251e-45c2-b02f-6a1a41c167d9)

## **Get-AdobeMetaData**
The functions can be used for Adobe automation. This will either grab the XMP data directly or utilize ExifTool to grab it. The Data is stored in a hash table.

**$AdobeMetadata = Get-AdobeMetadata -AdobeFile $AdobeFile -ExifTool $ExifTool**

After running the function any parameter can be read from the $AdobeMetadata variable:
- For a category: **$AdobeMetaData['Basic']**
- A specific value: **$AdobeMetaData['Basic']['CreatorTool']**

Two options are available
- To output the XMP data: **OutputXMP**<br />
**$AdobeMetadata = Get-AdobeMetadata -AdobeFile $AdobeFile -ExifTool $ExifTool -OutputXMP**
- To output a formatted text file: **OutputTXT**<br />
**$AdobeMetadata = Get-AdobeMetadata -AdobeFile $AdobeFile -ExifTool $ExifTool -OutputTXT**

They can be used together. The output will be the same location as the input with **_metadata** added to the filename. 

## **List-AdobeMetadata**
This will list the collected Metadata and can be used to save the metadata to a text file.
**List-AdobeMetadata $AdobeMetadata**

Two options are available
- To silence the log output: **Quiet**<br />
**List-AdobeMetadata -Quiet**
- To capture the formatted metadata **Output**<br />
**$FormattedMetadata = List-AdobeMetadata $AdobeMetadata -Output**


## **TestFiles**
I've included two testfiles.
- **xmp_photoshop.xml** this is all the properties found in Photoshop **File>File Info...**.
- **xmp_cases.xml** this is all different XMP structures that i came across. There are most probably more but i don't know.


## **Additional Notes**
- Adobe Premiere (*.prproj) does not have XMP data stored. 'prproj' files are *.zip files.
- After Effects (*.aep) has XMP info stored in the Binary. ExifTool fails to grab it for some reason. Trimmin it out of the Binary does not always work.
- Adobe InDesign (*.idml) is also a *.zip file. The XMP data is directly opened from within the file.
- XMP/XML files can be read directly and then parsed. If **-OutputXMP** is used it will be ignored to avoid overwriting the input.


## **Dependencies**
You'll need ExifTool by Phil Harvey to read out the XMP Metadata.


## Changelog

v1.0 (initial release)
