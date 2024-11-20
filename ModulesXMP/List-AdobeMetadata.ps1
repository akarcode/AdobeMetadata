function List-AdobeMetadata {

    param (

        [Collections.SortedList]$Collection,
        [switch]$Quiet,
        [switch]$Output

    )

    $Script:OutputText = @()

    function List-Value ($CurrentItem, [switch]$IsSub) {

        if ($IsSub) {
            
            $Gap = '        '
            $Width = -23

        } else {
            
            $Gap = '    '
            $Width = -27

        }


        if ($CurrentItem.Value -is [object[]]) {
                    
            $Counter = 0

            foreach ($SubItem in $CurrentItem.Value) {

                if ($Counter -eq 0) {

                    $Line = "$Gap{0,$Width} : {1}" -f $CurrentItem.Key, $SubItem
                    if (!$Quiet) { Write-Host $Line }
                    if ($Output) { $Script:OutputText += $Line }

                } else {
                            
                    $Line = "$Gap{0,$Width}   {1}" -f '', $SubItem
                    if (!$Quiet) { Write-Host $Line }
                    if ($Output) { $Script:OutputText += $Line }
                            
                }

                $Counter++

            }
        } else {
                    
            $Line = "$Gap{0,$Width} : {1}" -f $CurrentItem.Key, $CurrentItem.Value
            if (!$Quiet) { Write-Host $Line }
            if ($Output) { $Script:OutputText += $Line }

        }
    }


    # neatly output result
    foreach ($Entry in $Collection.Keys) {

        $Line = $Entry
        if (!$Quiet) { Write-Host $Line -ForegroundColor Yellow }
        if ($Output) { $Script:OutputText += $Line }

        foreach ($Item in $Collection[$Entry].GetEnumerator()) { 
                    
            if ($Item.Value -is [System.Collections.SortedList]) {
                        
                $Line = "    {0}" -f $Item.Key
                if (!$Quiet) { Write-Host $Line -ForegroundColor Magenta }
                if ($Output) { $Script:OutputText += $Line }

                foreach ($SubItem in $Item.Value.GetEnumerator()) { 
                    
                    List-Value -CurrentItem $SubItem -IsSub

                }
            } else {
                
                List-Value -CurrentItem $Item

            }
        }

        if (!$Quiet) { Write-Host '' }
        if ($Output) { $Script:OutputText += '' }

    }

    return $Script:OutputText

}