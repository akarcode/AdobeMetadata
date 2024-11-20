function Get-Resource {

    param (
        
        [Xml.XmlElement]$CurrentNode,
        [string]$SubCategory,
        [string]$SubSubCategory,
        [string]$NodeName

    )

    if (![string]::IsNullOrEmpty($SubSubCategory)) {
        
        $SubCategory = $SubSubCategory
        
    }

    $Resource = $CurrentNode.Attributes.GetNamedItem('rdf:parseType').Value

    if ($Resource -eq 'Resource') {

        if (![string]::IsNullOrEmpty($SubSubCategory)) {
            
            $SubCategory = $SubCategory + '_' + $CurrentNode.LocalName

        } else {

            $SubCategory = $NodeName

        }

        foreach ($Child in $CurrentNode.ChildNodes) {
            
            if ([string]::IsNullOrEmpty($SubSubCategory)) {
                
                Get-Resource -CurrentNode $Child -SubCategory $SubCategory -NodeName $NodeName
                
            } else {

                Get-Resource -CurrentNode $Child -SubSubCategory $SubCategory -NodeName $Child.LocalName
            
            }
        }
    } else {

        Process-Node -CurrentNode $CurrentNode -SubCategory $SubCategory

    }
}