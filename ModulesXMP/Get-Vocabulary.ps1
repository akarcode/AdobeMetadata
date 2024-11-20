function Get-Vocabulary {

    param (
        
        [string]$Value

    )

    $Vocabulary = $Value.StartsWith('http://ns.useplus.org/ldf/vocab/')
    $DigitalTyp = $Value.StartsWith('http://cv.iptc.org/newscodes/digitalsourcetype/')
    
    if ($Vocabulary -or $DigitalTyp) {

        $CurrentValue = $Value.Split('/')[-1]

        $CurrentValue = switch ($CurrentValue) {
        
            'work' { 'Work' }
            'cell' { 'Cell' }
            'fax' { 'Fax' }
            'home' { 'Home' }
            'pager' { 'Pager' }
            'IF-MFN' { 'Maintain File Name' }
            'IF-MID' { 'Maintain ID in File Name' }
            'IF-MMD' { 'Maintain Metadata' }
            'IF-MFT' { 'Maintain File Type' }
            'AL-CRP' { 'No Cropping' }
            'AL-FLP' { 'No Flipping' }
            'AL-RET' { 'No Retouching' }
            'AL-CLR' { 'No Colorization' }
            'AL-DCL' { 'No De-Colorization' }
            'AL-MRG' { 'No Merging' }
            'DP-NDC' { 'No Duplication Constraints' }
            'DP-LIC' { 'Duplication Only as Necessary Under License' }
            'DP-NOD' { 'No Duplication' }
            'MR-NON' { 'None' }
            'MR-NAP' { 'Not Applicable' }
            'MR-UMR' { 'Unlimited Model Releases' }
            'MR-LMR' { 'Limited or Incomplete Model Releases' }
            'AG-UNK' { 'Age Unknown' }
            'AG-A25' { 'Age 25 or Over' }
            'AG-A24' { 'Age 24' }
            'AG-A23' { 'Age 23' }
            'AG-A22' { 'Age 22' }
            'AG-A21' { 'Age 21' }
            'AG-A20' { 'Age 20' }
            'AG-A19' { 'Age 19' }
            'AG-A18' { 'Age 18' }
            'AG-A17' { 'Age 17' }
            'AG-A16' { 'Age 16' }
            'AG-A15' { 'Age 15' }
            'AG-U14' { 'Age 14 or Under' }
            'PR-NON' { 'None' }
            'PR-NAP' { 'Not Applicable' }
            'PR-UPR' { 'Unlimited Property Releases' }
            'PR-LPR' { 'Limited or Incomplete Property Releases' }
            'CR-NRQ' { 'Not Required' }
            'CR-COI' { 'Credit on Image' }
            'CR-CAI' { 'Credit Adjacent To Image' }
            'CR-CCA' { 'Credit in Credits Area' }
            'CW-NRQ' { 'Not Required' }
            'CW-AWR' { 'Adult Content Warning Required' }
            'CW-UNK' { 'Unknown' }
            'TY-PHO' { 'Photographic Image' }
            'TY-ILL' { 'Illustrated Image' }
            'TY-MCI' { 'Multimedia or Composited Image' }
            'TY-VID' { 'Video' }
            'TY-OTR' { 'Other' }
            'FF-JPG' { 'JPEG Interchange Formats (JPG, JIF, JFIF)' }
            'FF-TIF' { 'Tagged Image File Format (TIFF)' }
            'FF-GIF' { 'Graphics Interchange Format (GIF)' }
            'FF-RAW' { 'Proprietary RAW Image Format' }
            'FF-DNG' { 'Digital Negative (DNG)' }
            'FF-EPS' { 'Encapsulated PostScript (EPS)' }
            'FF-BMP' { 'Windows Bitmap (BMP)' }
            'FF-PSD' { 'Photoshop Document (PSD)' }
            'FF-PIC' { 'Macintosh Picture (PICT)' }
            'FF-PNG' { 'Portable Network Graphics (PNG)' }
            'FF-WMP' { 'Windows Media Photo (HD Photo)' }
            'FF-OTR' { 'Other' }
            'SZ-U01' { 'Up to 1 MB' }
            'SZ-U10' { 'Up to 10 MB' }
            'SZ-U30' { 'Up to 30 MB' }
            'SZ-U50' { 'Up to 50 MB' }
            'SZ-G50' { 'Greater than 50 MB' }
            'CS-PRO' { 'Protected' }
            'CS-PUB' { 'Public Domain' }
            'CS-UNK' { 'Unknown' }
            'RE-REU' { 'Repeat Use' }
            'RE-NAP' { 'Not Applicable' }
            'DMI-UNSPECIFIED' { 'Unspecified - no prohibition defined' }
            'DMI-ALLOWED' { 'Allowed' }
            'DMI-PROHIBITED-AIMLTRAINING' { 'Prohibited for AI/ML training' }
            'DMI-PROHIBITED-GENAIMLTRAINING' { 'Prohibited for Generative AI/ML training' }
            'DMI-PROHIBITED-EXCEPTSEARCHENGINEINDEXING' { 'Prohibited except for search engine indexing' }
            'DMI-PROHIBITED' { 'Prohibited' }
            'DMI-PROHIBITED-SEECONSTRAINT' { 'Prohibited, see Other Constraints property' }
            'DMI-PROHIBITED-SEEEMBEDDEDRIGHTSEXPR' { 'Prohibited, see Embedded Encoded Rights Expression property' }
            'DMI-PROHIBITED-SEELINKEDRIGHTSEXPR' { 'Prohibited, see Linked Encoded Rights Expression property' }
            'digitalCapture' { 'Digital capture sampled from real life' }
            'computationalCapture' { 'Multi-frame computational capture sampled from real life' }
            'negativeFilm' { 'Digitised from a transparent negative' }
            'positiveFilm' { 'Digitised from a transparent positive' }
            'print' { 'Digitised from a non-transparent medium' }
            'minorHumanEdits' { 'Original media with minor human edits' }
            'humanEdits' { 'Human-edited media' }
            'compositeWithTrainedAlgorithmicMedia' { 'Edited using Generative AI' }
            'algorithmicallyEnhanced' { 'Algorithmically-altered media' }
            'softwareImage' { 'Created by software' }
            'digitalArt' { 'Digital art' }
            'digitalCreation' { 'Digital creation' }
            'dataDrivenMedia' { 'Data-driven media' }
            'trainedAlgorithmicMedia' { 'Created using Generative AI' }
            'algorithmicMedia' { 'Pure algorithmic media' }
            'screenCapture' { 'Screen capture' }
            'virtualRecording' { 'Virtual event recording' }
            'composite' { 'Composite of elements' }
            'compositeCapture' { 'Composite of captured elements' }
            'compositeSynthetic' { 'Composite including generative AI elements' }

        }

        return $CurrentValue

    } else {

        return $Value

    }
}