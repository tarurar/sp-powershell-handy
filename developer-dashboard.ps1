$d = [Microsoft.SharePoint.Administration.SPWebService]::ContentService.DeveloperDashboardSettings;
#sp2013
$d.DisplayLevel = "On";

#sp2007 - sp2010
#$d.DisplayLevel = "OnDemand";

$d.RequiredPermissions = "EmptyMask";
$d.TraceEnabled = $true;
$d.Update();