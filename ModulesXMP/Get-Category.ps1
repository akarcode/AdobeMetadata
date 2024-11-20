function Get-Category ([string]$Value) {

    #https://exiftool.org/TagNames/XMP.html

    switch ($Value) {

        'aas'             { 'AppleAdjustmentSettings' }
        'ACDSee'          { 'ACDSystemsACDSee' }
        'acdsee-rs'       { 'ACDSeeRegions' }
        'album'           { 'AdobeAlbum' }
        'apple-fi'        { 'AppleFaceInformation' }
        'ast'             { 'Nikon' }
        'aux'             { 'Camera' }
        'cc'              { 'CreativeCommons' }
        'cell'            { 'SonyLocation' }
        'crd'             { 'AdobeCameraRaw' }
        'creatorAtom'     { 'AfterEffects' }
        'crs'             { 'Camera' }
        'dc'              { 'Basic' }
        'Device'          { 'GoogleDepthMapDevice' }
        'dex'             { 'Basic' }
        'DICOM'           { 'DICOM' }
        'digiKam'         { 'DigiKam' }
        'drone-dji'       { 'DJI' }
        'dwc'             { 'DarwinCore' }
        'et'              { 'ExifTool' }
        'exif'            { 'Camera' }
        'exifEX'          { 'Camera' }
        'expressionmedia' { 'MicrosoftExpressionMedia' }
        'extensis'        { 'ExtensisPortfolio' }
        'fpv'             { 'FastPictureViewer' }
        'GAudio'          { 'GaudioLabsAudio' }
        'GCamera'         { 'GaudioLabsCamera' }
        'GContainer'      { 'GaudioLabsContainer' }
        'GCreations'      { 'GaudioLabsCreations' }
        'GDepth'          { 'GaudioLabsDepth' }
        'GFocus'          { 'GaudioLabsFocus' }
        'GImage'          { 'GaudioLabsImage' }
        'GPano'           { 'GaudioLabsPano' }
        'GSpherical'      { 'GaudioLabsSpherical' }
        'getty'           { 'GettyImages' }
        'hdr'             { 'Camera' }
        'hdrgm'           { 'AdobeGainMap' }
        'ics'             { 'IDimager' }
        'idPriv'          { 'InDesign' }
        'illustrator'     { 'Illustrator' }
        'Iptc4xmpCore'    { 'IPTC' }
        'Iptc4xmpExt'     { 'IPTCExtension' }
        'plus'            { 'IPTCExtension' }
        'LImage'          { 'RED' }
        'lr'              { 'Lightroom' }
        'mediapro'        { 'IViewMediaPro' }
        'microsoft'       { 'MicrosoftPhoto1' }
        'MP'              { 'MicrosoftPhoto12' }
        'MP1'             { 'MicrosoftPhoto11' }
        'mwg-coll'        { 'MWGCollections' }
        'mwg-kw'          { 'MWGKeywords' }
        'mwg-rs'          { 'MWGRegions' }
        'nine'            { 'Nikon' }
        'panorama'        { 'AdobePhotoshopPanorama' }
        'pdf'             { 'PDF' }
        'pdfx'            { 'PDF' }
        'photomech'       { 'PhotoMechanic' }
        'photoshop'       { 'Photoshop' }
        'PixelLive'       { 'PixelLive' }
        'pmi'             { 'PRISM' }
        'prism'           { 'PRISM' }
        'prl'             { 'PRISMRights' }
        'prm'             { 'PRISMRecipe' }
        'pur'             { 'PRISMUsageRights' }
        'sdc'             { 'Nikon' }
        'seal'            { 'SEAL' }
        'swf'             { 'AdobeSWF' }
        'tiff'            { 'TIFF' }
        'xmp'             { 'Basic' }
        'xmpBJ'           { 'BasicJob' }
        'xmpDM'           { 'DynamicMedia' }
        'xmpDSA'          { 'PanasonicDSA' }
        'xmpMM'           { 'MediaManagement' }
        'xmpNote'         { 'Note' }
        'xmpPLUS'         { 'PictureLicensingUniversalSystem' }
        'xmpRights'       { 'Basic' }
        'xmpTPg'          { 'PagedText' }

        default { 'Other' }

    }
}















