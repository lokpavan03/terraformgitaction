# terraformgitaction 

## POC on Azure Infrastructure build from Terraform Cloud with GitHub Actions.

_**GitHub Setup**_

1. Create a GitHub account use the following URL **[GitHubJoin](https://github.com/join)** if account doesn't exists.
2. Once the GitHub account created login to the GitHub portal with Username and Password.
3. Create a Repository.
4. Create TF_API_TOKEN secret under the secrets which is available under settings. (Follow Step 6&7 under Terraform Cloud Setup to get the Token)
5. Upload the terraform scripts to the GitHub repository.
6. Create action file for deployment under .github/workflow/
7.  

_**Terraform Cloud Setup**_

1. Create a Terraform Cloud account use the following URL **[TerraformCloud](https://www.terraform.io/cloud)** if account doesn't exists.
2. Once the Terraform Cloud account created login to the Terraform Cloud portal with Username and Password.
3. Create an organization if you are new to Terraform cloud or use the existing organization.
4. Create a workspace while creating it choose API_driven workflow environment type and provide the workspace name.
5. Setup API_TOKEN for GitHub to Terraform Cloud connection setup
6. Go to workspace -> Settings -> Under the organizational settings blade choose API Tokens -> Under the API Tokens create Team Tokens -> Copy the Token.
7. Save the token as TF_API_TOKEN in GitHub Secrets.
8. Create terraform.tfvars variables under the Workspace
9. Service Principal login needs the following variables and get the values from the Azure App
--------
           _subscription_id_
           _client_id_ 
           _client_secret_
           _tenant_id_
          
_**Azure RBAC for Service Principal**_

1. Login to Azure Portal with credentials if you don't have account create a new account. Follow the URL for create account **[AzurePortal](https://portal.azure.com)**
2. Navigate to Azure Active Directory, under the Manage blade choose App Registrations.
3. Click on New registration provide the necessary inputs and register the app.
4. Save the **client_id** and **tenant_id** as a variables under Terraform cloud as sensitive data.
5. Go to the registered app and create a **client_secret** and add the varaiable under the Terraform cloud as sensitive data.
6. Go to the subscriptions on the overview get the **subscription_id** and add the varaiable under the Terraform cloud as sensitive data. 
7. Now assign the role based access policies to the registered App.
8. Go to the subscriptions select Access Control(IAM) the select Add Role Assignment.
9. Under Add Role Assignment blade
----------
        * _Role : **Contributor**_
        * _Assign access to : **User, group or service principal**
        * _select : **Register App**

10. Save the configuration.

_**Azure Resource Validation**_

1. Login to the Azure Portal with your credentials
2. Go to resouce group and check for **TFCloudRG007** if it exists find the resources under the resourc group 
3. Validate whether the below resources exists or not
----------
           * _Resource Group: **TFCloudRG007**_
           * _Virtual Network: **Vnet-tf**_
           * _Subnet: **Subnet01**_
           * _Public IP: **myPublicIP**_
           * _Network Security Group: **TFC_NSG**_
           * _Network Interface: **myNIC**_
           * _Virtual Machine: **TFCloud**_
           
