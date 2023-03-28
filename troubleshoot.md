# Troubleshoot Application Gateway

## 404
- ```annotations.appgw.ingress.kubernetes.io/appgw-ssl-certificate:``` Check that you are pointing against a valid certification name (stored in your Azure Key Vault) in your ingress file.
  
