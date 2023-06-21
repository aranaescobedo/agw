<#
    .DESCRIPTION
        The script is customized to be used in an Azure DevOps (ADO) pipeline. It updates the custom error page URL for a specified listener 
        in an Azure application gateway and also updates the backend target and settings for the associated rule.

    .NOTES
        AUTHOR: Alexander Arana E
        LASTEDIT: June 21, 2023
#>

param(
    [Parameter(Mandatory = $true)]
    [string]
    $agwName,
    [Parameter(Mandatory = $true)]
    [string]
    $agwRsgName,
    [Parameter(Mandatory = $true)]
    [string]
    [ValidateSet("test", "prod")]
    $env,
    [Parameter(Mandatory = $true)]
    [string]
    $listenerHostName
)

"[*] Get the listeners..."
$listeners = (az network application-gateway http-listener list `
                --gateway-name $agwName `
                --resource-group $agwRsgName `
                --query "[?hostNames[?@=='$listenerHostName'] && protocol=='Https']" | ConvertFrom-Json)

foreach ($listener in $listeners) {

    "[*] Set Error page URL on listener $($listener.name)"
    az network application-gateway http-listener update `
    --gateway-name $agwName `
    --resource-group $agwRsgName `
    --name $listener.name `
    --set customErrorConfigurations=@payload.json

    "[*] Get rule name.."
    $ruleName = (az network application-gateway rule list `
                --gateway-name $agwName `
                --resource-group $agwRsgName `
                --query "[?httpListener.id=='$($listener.id)']" | ConvertFrom-Json).name
                    
    "[*] Set backend target and setting on rule ${ruleName}"
    az network application-gateway rule update `
                --gateway-name $agwName `
                --resource-group $agwRsgName `
                --name  $ruleName `
                --address-pool "defaultaddresspool" `
                --http-settings "defaulthttpsetting"
}
