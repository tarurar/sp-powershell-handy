function Remove-SPListView {
Param(
[string]$WebUrl,
[string]$ListName,
[string]$ViewName
)
    Start-SPAssignment -Global
    $SPWeb = Get-SPWeb $WebUrl
    $List = $SPWeb.Lists[$ListName]
    $View = $List.Views[$ViewName]
    $List.Views.Delete($View.ID)
    $List.Update()
    $SPWeb.Update()
    $SPWeb.Dispose()
    Stop-SPAssignment -Global
}

function Remove-ListAllViews {
Param(
[string]$WebUrl,
[string]$ListName
)
    Start-SPAssignment -Global
    $SPWeb = Get-SPWeb $WebUrl
    $List = $SPWeb.Lists[$ListName]

    foreach ($view in $List.Views) {
        if (!$view.DefaultView) {
            Remove-SPListView $WebUrl $ListName $view.Title
        }
    }

    Stop-SPAssignment -Global
}