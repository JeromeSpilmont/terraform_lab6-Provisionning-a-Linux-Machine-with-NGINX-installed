# lab6 - Provision EC2 Instance on AWS 
## Provisioning a Linux Machine with NGINX installed

Prerequisites:

- AWS account
- Terraform installed
- Key pair

---

Steps:
- Import the private key in **pem** format
- Create a **terraform.tfvars** file with your data

    ```
    region = "us-east-1"
    aws_access_key = "*****Your*aws*access*key******"
    aws_secret_key = "*****Your*aws*secret*key******"
    key_name = "yourkey"
    private_key_path = "./yourkey.pem"
    instance_name = "Lab6-AmazonLinux-nginx"
    ```

---

Terraform:
- The `terraform init` command initializes a working directory containing configuration files and installs plugins for required providers.

- The `terraform plan` command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure.

- The `terraform apply` command executes the actions proposed in a Terraform plan to create, update, or destroy infrastructure.

