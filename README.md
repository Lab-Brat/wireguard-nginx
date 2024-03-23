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
cd terraform/
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


### Additional Info
Firewall rules are set up to open port 80 and 443 publicly on deployment. 
This is because letsencrypt need them to pass http-01 challenge. Ports can 
be restricted afterward by modifying firewall rules:
```
....
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["${chomp(data.http.myip.response_body)}/32"]
  }
....
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["${chomp(data.http.myip.response_body)}/32"]
  }
```

To undeploy everything run:
```shell
cd terraform/
terraform destroy
```