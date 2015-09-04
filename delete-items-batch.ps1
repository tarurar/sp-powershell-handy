if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

$list =  (Get-SPweb http://10.176.205.10).GetList("Lists/LicenseList");
$query = New-Object Microsoft.SharePoint.SPQuery;
$query.ViewAttributes = "Scope='Recursive'";
$query.RowLimit = 2000;

$itemCount = 0;
$listId = $list.ID;
[System.Text.StringBuilder]$batchXml = New-Object "System.Text.StringBuilder";
$batchXml.Append("<?xml version=`"1.0`" encoding=`"UTF-8`"?><Batch>");
$command = [System.String]::Format( "<Method><SetList>{0}</SetList><SetVar Name=`"ID`">{1}</SetVar><SetVar Name=`"Cmd`">Delete</SetVar></Method>", $listId, "{0}" );

do
{
    $listItems = $list.GetItems($query)
    $query.ListItemCollectionPosition = $listItems.ListItemCollectionPosition
    foreach ($item in $listItems)
    {
        if($item -ne $null){$batchXml.Append([System.String]::Format($command, $item.ID.ToString())) | Out-Null;$itemCount++;}
    }
}
while ($query.ListItemCollectionPosition -ne $null)

$batchXml.Append("</Batch>");
$itemCount;

$web = Get-Spweb http://10.176.205.10;
$web.ProcessBatchData($batchXml.ToString()) | Out-Null;

