# Troubleshoot Application Gateway

## 404
- ```annotations.appgw.ingress.kubernetes.io/appgw-ssl-certificate:``` Check that you are pointing against a valid certification name (stored in your Azure Key Vault) in your ingress file.
  
## 500 or 502 (Bad gateway)

- Check the pod log (```kubectl -n myNameSpaceName logs podName```) becuase it could mean that your pod is not up and running in the correct way.
