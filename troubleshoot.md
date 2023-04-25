# Troubleshoot Application Gateway
This README contains a collection of solutions for common troubleshooting scenarios that may arise when using Azure Application Gateway.

## 403
- Check that the configuration of the custom rules in the Application Gateway WAF policy (Web Application Firewall).
- Check that the request coming into the Application Gateway has the ```host_s``` field in the call:
![log image](/images/log.png)
- AP: Add link to the query you are creating

## 404
- ```annotations.appgw.ingress.kubernetes.io/appgw-ssl-certificate:``` Check that you are pointing against a valid certification name (stored in your Azure Key Vault) in your ingress file.
  
## 500 or 502 (Bad gateway)

- Check the pod log (```kubectl -n myNameSpaceName logs podName```) becuase it could mean that your pod is not up and running in the correct way.
