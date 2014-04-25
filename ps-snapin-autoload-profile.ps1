if (!(test-path $profile.AllUsersAllHosts)) 
{
    new-item -type file -path $profile.AllUsersAllHosts –force
}

powershell_ise $profile.AllUsersAllHosts

#In PowerShell ISE, you will now have a new tab where you can edit this file.  In that new tab, add the following code and then save the file.

#$ver = $host | select version
#if ($ver.Version.Major -gt 1) {$host.Runspace.ThreadOptions = "ReuseThread"} 
#if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
#{
#    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
#}