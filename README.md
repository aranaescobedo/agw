<p align="center">
 <img width="100px" src="images/application-gateways.svg" align="center" alt="Azure Application Gateway" />
 <h2 align="center">Azure AGW (Application gateway)</h2>
 <p align="center">This repository provides resources for managing and troubleshooting Azure Application Gateway!</p>
</p>

## Prerequisites
- [A valid Azure account][azure-account]

## File Descriptions

- **[agw-request-logs.kql]**:  The query filters Application Gateway logs based on the HTTP status code, original host, and request URL, among other parameters, to pinpoint issues.

- **[blocked-agw-firewall-logs.kql]**: The query retrieves Azure Application Gateway firewall logs where a specific action was blocked, filtered by hostname, gateway name, and request URL.

- **[matched-agw-firewall-logs.kql]**: This query identify which managed rules are blocking incoming requests to the application gateway.

- **[troubleshoot.md]**: The readme file provides troubleshooting information and solutions for various issues related to Azure Application Gateway.

## Usage
Each file in this folder is designed to perform a specific task with AGW or provide troubleshooting information. Before running a file or using any of the provided information, make sure to replace any placeholder wrapped around ```'<>'``` with your own information and follow the instructions carefully

## Disclaimer
Please note that this is provided as-is and may not suit all use cases. Use at your own discretion and make sure to thoroughly test before deployment in a production environment.

[azure-account]: https://azure.microsoft.com/en-us/free
[agw-request-logs.kql]:agw-request-logs.kql
[blocked-agw-firewall-logs.kql]:blocked-agw-firewall-logs.kql
[matched-agw-firewall-logs.kql]:matched-agw-firewall-logs.kql
[troubleshoot.md]:troubleshoot.md
