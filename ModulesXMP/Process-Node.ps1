function Process-Node {

    param (
        
        [Xml.XmlElement]$CurrentNode,
        [string]$SubSubCategory,
        [string]$SubCategory

    )

    $BagNode = $CurrentNode.SelectSingleNode('rdf:Bag', $nsManager)
    $SeqNode = $CurrentNode.SelectSingleNode('rdf:Seq', $nsManager)

    if ($SeqNode -or $BagNode) {

        $TypeNode = if ($BagNode) { $BagNode } else { $SeqNode }

        $SubNode = $CurrentNode.SelectSingleNode('rdf:' + $TypeNode.LocalName, $nsManager)
        $ListNode = $SubNode.SelectSingleNode('rdf:li', $nsManager)
        $Resource = $ListNode.Attributes.GetNamedItem("rdf:parseType").Value

        # resource lists have multiple values inside each list items
        if ($Resource -eq 'Resource') {
            
            $Counter = 0

            foreach ($Child in $SubNode.ChildNodes) {
                
                $CounterDigits = [math]::Floor([math]::Log10($SubNode.ChildNodes.Count)) + 1
                $CounterPadded = $Counter.ToString().PadLeft($CounterDigits, '0')

                if (![string]::IsNullOrEmpty($SubSubCategory) -and $SubNode.ChildNodes.Count -gt 1) {
                    
                    $SubCategory = $SubSubCategory + '_' + $CurrentNode.LocalName + '_' + $CounterPadded

                } elseif (![string]::IsNullOrEmpty($SubSubCategory)) {

                    $SubCategory = $SubSubCategory + '_' + $CurrentNode.LocalName

                } elseif ($SubNode.ChildNodes.Count -gt 1) {

                    $SubCategory = $CurrentNode.LocalName + '_' + $CounterPadded

                } else {

                    $SubCategory = $CurrentNode.LocalName

                }

                foreach ($SubChild in $Child.ChildNodes) {

                    $Resource = $SubChild.Attributes.GetNamedItem("rdf:parseType").Value
                    $BagNode = $SubChild.SelectSingleNode('rdf:Bag', $nsManager)
                    $SeqNode = $SubChild.SelectSingleNode('rdf:Seq', $nsManager)

                    if ($Resource -eq 'Resource') {

                        Get-Resource -CurrentNode $SubChild -SubSubCategory $SubCategory -NodeName $SubChild.LocalName

                    } elseif ($SeqNode -or $BagNode) {

                        Process-Node -CurrentNode $SubChild -SubSubCategory $SubCategory
                    
                    } else {
                    
                        if (!$Collection[$Category].ContainsKey($SubCategory) -and $SubCategory) {

                            $Collection[$Category][$SubCategory] = [Collections.SortedList]::new()

                        }

                        $NodeValue = Get-NodeValue -NodeName $SubChild.LocalName -Value $SubChild.InnerText

                        if ($NodeValue -match "`n") {

                            Process-ListItems -ListItems ($NodeValue -split '\r?\n') -Category $Category -SubCategory $SubCategory -ListName $SubChild.LocalName

                        } else {
                            
                            $EditedValue = Get-Vocabulary -Value $NodeValue
                        
                            $Collection[$Category][$SubCategory][$SubChild.LocalName] = $EditedValue

                        }
                    }
                }

                $Counter++

            }
        } else {

            if (![string]::IsNullOrEmpty($SubSubCategory)) {

                $SubCategory = $SubSubCategory

            }

            if (!$Collection[$Category].ContainsKey($SubCategory) -and $SubCategory) {

                $Collection[$Category][$SubCategory] = [Collections.SortedList]::new()

            }

            # for lists that have single values inside
            $ItemList = $SubNode.SelectNodes('rdf:li', $nsManager) | ForEach-Object { $_.InnerText }
            
            Process-ListItems -ListItems $ItemList -Category $Category -SubCategory $SubCategory -ListName $CurrentNode.LocalName

        }
    } else {

        if (!$Collection[$Category].ContainsKey($SubCategory) -and $SubCategory) {

            $Collection[$Category][$SubCategory] = [Collections.SortedList]::new()

        }
        
        $NodeValue = Get-NodeValue -NodeName $CurrentNode.LocalName -Value $CurrentNode.InnerText

        if ($NodeValue -match "`n") {
            
            Process-ListItems -ListItems ($NodeValue -split '\r?\n') -Category $Category -SubCategory $SubCategory -ListName $CurrentNode.LocalName

        } else {
            
            $EditedValue = Get-Vocabulary -Value $NodeValue

            if ([string]::IsNullOrEmpty($SubCategory)) {
                
                $Collection[$Category][$CurrentNode.LocalName] = $EditedValue

            } else {

                if (!$Collection[$Category].ContainsKey($SubCategory) -and $SubCategory) {

                    $Collection[$Category][$SubCategory] = [Collections.SortedList]::new()

                }
                
                $Collection[$Category][$SubCategory][$CurrentNode.LocalName] = $EditedValue

            }
        }
    }
}