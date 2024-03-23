# Wireguard + Nginx

Configuration files for [wg-easy](https://github.com/wg-easy/wg-easy) installation with Nginx reverse proxy.  


### Deployment steps

#### Step 1
Install Ansible in the virtual environment:
```shell
python -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
```

Note that virtual environment should be avtive during terraform run.  


#### Step 2
Create a file with variables:
```shell
cd terraform
cp terraform.tfvars.example terraform.tfvars
```

Then go to DigitalOcean and Cloudflare to generate API tokens that will be used by Terraform.  


#### Step 3
Instantiate providers and launch Terraform:
```shell
terraform init
terraform plan -out .terraform.plan.zip
terraform apply .terraform.plan.zip
```