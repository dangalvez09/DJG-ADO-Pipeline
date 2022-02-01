This is a lab I am working on to deploy Terraform using Azure DevOps. **CURRENTLY STILL IN PROGRESS**

The goal is to create a basic framework for the Azure DevOps pipeline. This is a very simple terraform code which will setup:
1. The remote backend using terraform cloud
2. the Azure DevOps project
3. Variable group for the pipeline to use
4. The build pipeline
5. Lastly we need to deploy the simple Azure vnet module using the pipeline we created 