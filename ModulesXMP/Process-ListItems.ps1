function Process-ListItems {

    param (
        
        [array]$ListItems,
        [string]$Category,
        [string]$SubCategory,
        [string]$ListName

    )


    if ([string]::IsNullOrEmpty($SubCategory)) {

        $Location = $Collection[$Category]

    } else {

        $Location = $Collection[$Category][$SubCategory]

    }


    for ($i = 0; $i -lt $ListItems.Count; $i++) {
        
        $NodeValue = Get-NodeValue -NodeName $ListName -Value $ListItems[$i]
        $EditedValue = Get-Vocabulary -Value $NodeValue
        
        if ($i -eq 0) {
            
            if ($ListItems.Count -gt 1) { 

                $Location[$ListName] = @($EditedValue)

            } else {

                $Location[$ListName] = $EditedValue

            }
        } else {

            $Location[$ListName] += $EditedValue

        }
    }
}