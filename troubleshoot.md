# 🕵️ Troubleshoot Application Gateway
This README contains a collection of solutions for common troubleshooting scenarios that may arise when using Azure Application Gateway.

## 403
- Check that the custom rules in the Application Gateway WAF (Web Application Firewall) policy are not blocking the IP address from which your request is coming from.
  - Use **[agwFirewallLogsQuery.kql]** to troubleshoot.

- Check that the request coming into the Application Gateway has the ```host_s``` field in the call:
  - Use **[agwRequestLogsQuery.kql]** to troubleshoot.

![log image](/images/log.png)

## 404
- Check that you are pointing to a valid certificate name (stored in your Azure Key Vault) in your ingress file: ```annotations.appgw.ingress.kubernetes.io/appgw-ssl-certificate:```
  
## 500 or 502 (Bad gateway)

- Run pod logs (```kubectl -n myNameSpaceName logs podName```) because it could mean that your pod is not up and running correctly.

[agwFirewallLogsQuery.kql]:agwFirewallLogsQuery.kql
[agwRequestLogsQuery.kql]:agwRequestLogsQuery.kql
