# README

## Deployment steps

#### Configure AWS CLI
1. Configure AWS CLI with credentials required to run the script for terraform backend creation and to run terraform commands.

#### Update the backend.conf file  - if needed
1. Update `./terraform/config/backend.conf`
2. Use an appropriate bucket name (if needed).
3. Do the same for dynamodb table name (if needed).


#### Create an s3 bucket for Terraform backend - (run commands from terraform folder)
1. From root folder, change directory into terraform folder - `cd ./terraform`
2. Create s3 bucket for backend, for example, this command uses us-east-1 as an argument. The region can be changed to any desired region - `./config/create_backend.sh us-east-1`
3. If a different region is used above, it (the region) should be updated in the following files:
   > `terraform/backend.tf`
   > `terraform/env/dev.tfvars`

#### Update backend.tf file
1. Update the region (if needed) to match region used in creating s3 bucket.

#### Update dev.tfvars file
1. Update the region (if needed) to match region used in creating s3 bucket.

### Terraform apply
1. `cd terraform/`
2. `terraform init -backend-config="./config/backend.conf"`
3. `terraform plan -var-file=env/dev.tfvars`
4. `terraform apply -var-file=env/dev.tfvars --auto-approve`


### Docker - build image - (run commands from terraform folder)
1. `docker build -t quest ../quest-master/`

### ECR - push image to ECR - (run commands from terraform folder using AWS CLI)
1. login to ECR - `aws ecr get-login-password --region $(terraform output -raw region) | docker login --username AWS --password-stdin $(terraform output -raw aws_account_id).dkr.ecr.$(terraform output -raw region).amazonaws.com`
2. Tag image for ECR - `docker tag quest:latest $(terraform output -raw repo_url):latest`
3. Push image to ECR - `docker push $(terraform output -raw repo_url):latest`


### Restart ECS service to use pushed image - (run commands from terraform folder)
1. `aws ecs update-service --force-new-deployment --service $(terraform output -raw service1_name) --cluster $(terraform output -raw cluster_name)`

## View pages
>https://quest-master.chainomi.link/loadbalanced
>https://quest-master.chainomi.link/secret_word
>https://quest-master.chainomi.link/tls