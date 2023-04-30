# Personal Website Through Terraform

Terraform code built to run the infrastructure between CloudFlare and AWS to host personal website. The goal of this project was to be able to destory a set of infrastructure and build it back up all using IaC.

## Installation

Use [terraform](https://developer.hashicorp.com/terraform/downloads) to initialize infrastructure and pull this repository for use.

```git
git pull https://github.com/timothyedwarddean/tim-dean-website-terraform.git
```

```terraform
cd C:\project
terraform init
```

Alter variables.tf to associate with your following infrastructure:

* AWS Region of choice
* Domain you will be using
* Cloudflare API + ZoneID

Alter main.tf to use AWS configuration and credentials files to authenticate into AWS. I have this pointed to a C:\Users directory on my Windows 11 machine, but adjust according to your Unix/Windows distro.

The following information will need to be provided in \.aws\credentials

```text
[default]
aws_access_key_id = ACCESS_KEY_HERE
aws_secret_access_key = SECRET_ACCESS_KEY_HERE
```

The following information will need to be provided in \.aws\conf

```text
[default]
region=us-east-1
output=json
```

Upon having a working directory and proper credentials, plan your Terraform deployment.

```terraform
terraform plan
```

If content with proposed infrastructure, apply the code.

```terraform
terraform apply
```

## References

**s3.tf**

* Create static S3 bucket of tim-dean.com. Allow force destroy so terraform can destory it on demand.
* Using above S3 bucket, allow S3 to host static website pointing to index.html upon opening.
* Open up bucket to public with GetObject policy to allow retrieval of HTML and CSS.
* Create www bucket to allow DNS resolution and redirect to above S3 bucket.

**cloudflare.tf**

* Creates CNAME entry to point to S3 website that is hosting our website.
* Creates CNAME entry for www. access to website.
* Forces HTTPS use in Cloudflare for SSL encryption.
* Redirects tim-dean.com/learn to Terraform because why not?
* Geolocation block to only allow North American IPs to restrict viewing since this is for personal, local use.

**route53.tf**

* Forces nameservers to use Cloudflare in repeatable fashion.

**vpc.tf**

* This is not technically needed but wanted some public/private CIDRs in the case I decide to attach EC2 instances to website.


## Contributing

Pull requests are welcome if you would like to use this for a personal project.
