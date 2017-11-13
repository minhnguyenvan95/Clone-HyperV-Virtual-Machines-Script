$coreXml = "core.xml"
$currentDir = $PSScriptRoot;
$coreXmlPath = $currentDir + "\" + $coreXml

function Clone-HyperV{
    param([string] $xmlPath,[string] $bsName, [string] $VMDefaultPath)
    $newPath = $currentDir + "\temp\" + [guid]::NewGuid() + ".xml"

    Write-Host "Create temp file :"$newPath

    [xml]$XmlDocument = Get-Content -Path $xmlPath
    $XmlDocument.configuration.properties.name."#text" = $bsName
    $xmlDocument.Save($newPath)
    
    IMPORT-VM -path $newPath -Copy -VhdDestinationPath $VMDefaultPath -VirtualMachinePath $VMDefaultPath -SnapshotFilePath $VMDefaultPath"Snapshots" -SmartPagingFilePath $VMDefaultPath"SmartPaging" -GenerateNewId
}

For ($i=1; $i -le 11; $i++) {
    Clone-HyperV $coreXmlPath "BS$i" "C:\BS\"
}

For ($i=12; $i -le 23; $i++) {
    Clone-HyperV $coreXmlPath "BS$i" "D:\BS\"
}

For ($i=24; $i -le 35; $i++) {
    Clone-HyperV $coreXmlPath "BS$i" "E:\BS\"
}