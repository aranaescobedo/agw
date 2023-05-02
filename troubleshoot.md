# Troubleshoot Application Gateway
This README contains a collection of solutions for common troubleshooting scenarios that may arise when using Azure Application Gateway.

## 403
- Check that the custom rules in the Application Gateway WAF (Web Application Firewall) policy are not blocking the IP address from which your request is coming from.

- Check that the request coming into the Application Gateway has the ```host_s``` field in the call:
![log image](/images/log.png)
- AP: Add link to the query you are creating

## 404
- Check that you are pointing to a valid certificate name (stored in your Azure Key Vault) in your ingress file: ```annotations.appgw.ingress.kubernetes.io/appgw-ssl-certificate:```
  
## 500 or 502 (Bad gateway)

- Run pod logs (```kubectl -n myNameSpaceName logs podName```) because it could mean that your pod is not up and running correctly.
