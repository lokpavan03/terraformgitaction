# terraformgitaction 

## POC on Azure Infrastructure build from Terraform Cloud with GitHub Actions.

_**GitHub Setup**_
1. Create a GitHub account use the following URL **[GitHubJoin](https://github.com/join)** if account doesn't exists.
2. Once the GitHub account created login to the GitHub portal with Username and Password.
3. Create a Repository

_**Terraform Cloud Setup**_
1. Create a Terraform Cloud account use the following URL **[TerraformCloud](https://www.terraform.io/cloud)** fi account doesn't exists.
2. Once the Terraform Cloud account created login to the Terraform Cloud portal with Username and Password.
3. Create an organization 
4. Create a workspace
5. Setup API_TOKEN for GitHub to Terraform Cloud connection setup
6. Go to workspace -> Settings -> Under the organizational settings blade choose API Tokens -> Under the API Tokens create Team Tokens -> Copy the Token.
7. Save the token as TF_API_TOKEN in GitHub Secrets.
8. 
_**Azure RBAC for Service Principal**_
_**Azure Resource Validation**_
