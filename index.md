# Azure Infra Automation using Terraform Cloud with GitHub Actions.

<span style="color:black;">Contents</span>
- [GitHub Setup](#GitHub-Setup)
- [GitHub Actions](#GitHub-Actions)
- [Terraform Cloud Setup](#Terraform-Cloud-Setup)
- [Azure RBAC for Service Principal](#Azure-RBAC-for-Service-Principal)
- [Run the Scenario](#Run-the-Scenario)
- [Azure Resource Validation](#Azure-Resource-Validation)
  

## _**GitHub Setup**_

1. Create a GitHub account use the following URL **[GitHubJoin](https://github.com/join)** if account doesn't exists.
2. Once the GitHub account created login to the GitHub portal with Username and Password.
3. Create a Repository.
4. Create **TF_API_TOKEN** secret under the secrets which is available under settings. (Follow Step 6&7 under [Terraform Cloud Setup](#Terraform-Cloud-Setup) to get the Token)
5. Upload the terraform scripts to the GitHub repository.

![GitHub](https://github.com/lokpavan03/terraformgitaction/blob/main/gifs/github.gif?raw=true)

## _**GitHub Actions**_

1. Go to the Actions tab in GitHub.
2. Choose a Terraform workflow temaplate.
3. Update the template with the required actions.

![GitHubActionWF](https://github.com/lokpavan03/terraformgitaction/blob/main/gifs/githubactions.gif?raw=true)

## _**Terraform Cloud Setup**_

1. Create a Terraform Cloud account use the following URL **[TerraformCloud](https://www.terraform.io/cloud)** if account doesn't exists.
2. Once the Terraform Cloud account created login to the Terraform Cloud portal with Username and Password.
3. Create an organization if you are new to Terraform cloud or use the existing organization.
4. Create a workspace while creating it choose API_driven workflow environment type and provide the workspace name.

![Terraform_Cloud](https://github.com/lokpavan03/InfraAutoJenkinsTFCloud/blob/master/jpgs/TerraformWorkspace.gif?raw=true)

5. Setup API_TOKEN for GitHub to Terraform Cloud connection setup
6. Go to workspace -> Settings -> Under the organizational settings blade choose API Tokens -> Under the API Tokens create Team Tokens -> Copy the Token.
7. Save the token as TF_API_TOKEN in GitHub Secrets.
8. Create terraform.tfvars variables under the Workspace
9. Service Principal login needs the following variables and get the values from the Azure App

          * subscription_id
          * client_id
          * client_secret
          * tenant_id

![Terraform_Token](https://github.com/lokpavan03/InfraAutoJenkinsTFCloud/blob/master/jpgs/TerraformToken.gif?raw=true)
          
## _**Azure RBAC for Service Principal**_

1. Login to Azure Portal with credentials if you don't have account create a new account. Follow the URL for create account **[AzurePortal](https://portal.azure.com)**
2. Navigate to Azure Active Directory, under the Manage blade choose App Registrations.
3. Click on New registration provide the necessary inputs and register the app.

![ServicePrincipal](https://github.com/lokpavan03/terraformgitaction/blob/main/gifs/ServicePrincipal.gif?raw=true)

4. Save the **client_id** and **tenant_id** as a variables under Terraform cloud as sensitive data.
5. Go to the registered app and create a **client_secret** and add the varaiable under the Terraform cloud as sensitive data.
6. Go to the subscriptions on the overview get the **subscription_id** and add the varaiable under the Terraform cloud as sensitive data. 

![TFCVariables](https://github.com/lokpavan03/terraformgitaction/blob/main/gifs/TFCVariables.gif?raw=true)

7. Now assign the role based access policies to the registered App.
8. Go to the subscriptions select Access Control(IAM) the select Add Role Assignment.
9. Under Add Role Assignment blade

        * Role : Contributor
        * Assign access to : User, group or service principal
        * select : Register App

10. Save the configuration.

![SPRBAC](https://github.com/lokpavan03/terraformgitaction/blob/main/gifs/SPRBAC.gif?raw=true)

## _**Run the Scenario**_

1. Clone the GitHub Repository.
2. Create a branch from the main name it as hotfix** if branch doesn't exists else skip this step.
3. Checkout the hotfix** branch.
4. Modify the code changes.
5. Review, commit and push the changes to the repository.
6. Create a pull request from the hotfix** to main branch.
7. Once pull request raised a job will be trigger, it will run the terraform format, terraform init and terraform plan.
8. If step 7 finish successfully review the plan for changes in Infrastructure.
9. If step 7 fails check the log and modify the code and do step 5 again.
10.If step 8 success then Merge the pull request then it will trigger the job and run the terraform apply from pipeline.

![Workflow](https://github.com/lokpavan03/terraformgitaction/blob/main/gifs/Workflow.gif?raw=true)

11.A Terraform apply workflow will run on the Terraform Cloud. 
12.Check the status of the workflow under the workspace under the organization.
13.If step 12 applied successfully means your deployment got completed.

![TFWorkflow](https://github.com/lokpavan03/terraformgitaction/blob/main/gifs/TFcloud.gif?raw=true)

## _**Azure Resource Validation**_

1. Login to the Azure Portal **[AzurePortal](https://portal.azure.com)** with your credentials
2. Go to resouce group and check for created resources.
3. Validate whether the resources created or not.

![Azure Resources Validation](https://github.com/lokpavan03/InfraAutoJenkinsTFCloud/blob/master/jpgs/Validation.gif?raw=true)
           
Thanks,
Lok
