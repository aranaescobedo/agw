<#
    .DESCRIPTION
        The script is customized to be used locally, and it updates the custom error page URL for a specified listener 
        in an Azure application gateway while also updating the backend target and settings for the associated rule.

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
    $clusteName,
    [Parameter(Mandatory = $true)]
    [string]
    [ValidateSet("test", "prod")]
    $env,
    [Parameter(Mandatory = $true)]
    [string]
    $listenerHostName,
    [Parameter(Mandatory = $true)]
    [string]
    $subscriptionName
)

$filePath = "listener-ingress-prohibited.yaml"

$getRootDir = git rev-parse --show-toplevel
Set-Location "$getRootDir\<FILE_PATH>" #The placeholder <FILE_PATH> represents the file path or directory where the script is located within your Git repository.

#az login
az account set --subscription $subscriptionName
kubectl config use-context $clusteName
"[*] Set subscription $subscriptionName

"[*] Get the listeners..."
$listeners = (az network application-gateway http-listener list `
                --gateway-name $agwName `
                --resource-group $agwRsgName `
                --query "[?hostNames[?@=='$listenerHostName'] && protocol=='Https']" | ConvertFrom-Json)

foreach ($listener in $listeners) {
echo @"
apiVersion: "appgw.ingress.k8s.io/v1"
kind: AzureIngressProhibitedTarget
metadata:
    name: $($listener.name)-listener-ingress-prohibited
    namespace: kube-system
spec:
    hostname: $listenerHostName
"@ > $filePath | kubectl apply -f $filePath

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
