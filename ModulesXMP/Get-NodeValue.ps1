function Get-NodeValue {

    param (
        
        [string]$NodeName,
        [string]$Value

    )

    if ($NodeName -match 'Date' -or $NodeName -match 'PatientDOB' -or $NodeName -match 'when') {

        return $Value.Replace('T', ' | T').Replace('+', ' | +').Trim()

    

    } elseif ($NodeName -in 'instanceID', 'documentID', 'OriginalDocumentID') {
        
        if ($Value.Split(':').Count -gt 1) {
        
            return $Value.Split(':')[-1].Trim()

        } else {

            return $Value.Trim()

        }
    

    } elseif ($NodeName -eq 'Rating') {

        return ('●' * [int]$value) + ('○' * (5 - [int]$Value))
    
    

    } elseif ($NodeName -eq 'PatientSex') {

        return (Get-Culture).TextInfo.ToTitleCase($Value).Trim()

    

    } elseif ($NodeName -eq 'Marked') {

        $Value = switch ($Value) {

            'False' { 'Public Domain' }
            'True'  { 'Copyrighted' }

        }

        return $Value

    
    
    } elseif ($NodeName -eq 'ColorMode') {

        $Value = switch ($Value) {

            '0' { 'Bitmap' }
            '1' { 'Gray scale' }
            '2' { 'Indexed colour' }
            '3' { 'RGB colour' }
            '4' { 'CMYK colour' }
            '7' { 'Multi-channel' }
            '8' { 'Duotone' }
            '9' { 'LAB colour' }

        }

        return $Value


    
    } elseif ($NodeName -eq 'filePath' -or $NodeName -eq 'lastURL') {
        
        Add-Type -AssemblyName System.Web
        return [Web.HttpUtility]::UrlDecode($Value)



    } elseif ($NodeName -eq 'image' -or $NodeName -eq 'Thumbnails') {

        return 'This property contains binary data!'



    } elseif ($NodeName -eq 'Urgency') {

        $Value = switch ($Value) {

            '1' { 'High' }
            '5' { 'Normal' }
            '8' { 'Low' }

        }

        return $Value



    } else {

        return $Value.Trim()

    }
}


