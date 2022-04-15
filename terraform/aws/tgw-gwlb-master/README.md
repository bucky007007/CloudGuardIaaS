# Check Point CloudGuard Network Gateway Load Balancer for Transit Gateway Terraform Master module for AWS

Terraform module which deploys an AWS Auto Scaling group configured for Gateway Load Balancer into new Centralized Security VPC for Transit Gateway.
* [AWS Instance](https://www.terraform.io/docs/providers/aws/r/instance.html)
* [Security Group](https://www.terraform.io/docs/providers/aws/r/security_group.html)
* [Load Balancer](https://www.terraform.io/docs/providers/aws/r/lb.html)
* [Load Balancer Target Group](https://www.terraform.io/docs/providers/aws/r/lb_target_group.html)
* [Launch configuration](https://www.terraform.io/docs/providers/aws/r/launch_configuration.html)
* [Auto Scaling Group](https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html)
* [IAM Role](https://www.terraform.io/docs/providers/aws/r/iam_role.html) - conditional creation

See the [Check Point CloudGuard Gateway Load Balancer on AWS](https://sc1.checkpoint.com/documents/IaaS/WebAdminGuides/EN/CP_CloudGuard_Network_for_AWS_Centralized_Gateway_Load_Balancer/Content/Topics-AWS-GWLB-VPC-DG/Introduction.htm) for additional information

This solution uses the following modules:
- /terraform/aws/autoscale-gwlb
- /terraform/aws/modules/vpc
- /terraform/aws/management
- /terraform/aws/cme-iam-role
- /terraform/aws/modules/amis
- /terraform/aws/gwlb
## Configurations

The **main.tf** file includes the following provider configuration block used to configure the credentials for the authentication with AWS, as well as a default region for your resources:
```
provider "aws" {
    region = var.region
    access_key = var.aws_access_key_ID
    secret_key = var.aws_secret_access_key
}
```
The provider credentials can be provided either as static credentials or as [Environment Variables](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables).
- Static credentials can be provided by adding an access_key and secret_key in /terraform/aws/qs-autoscale/**terraform.tfvars** file as follows:
```
region     = "us-east-1"
access_key = "my-access-key"
secret_key = "my-secret-key"
```
- In case the Static credentials are used, perform modifications described below:<br/>
  a. The next lines in main.tf file, in the provider aws resource, need to be commented for sub-modules /terraform/aws/autoscale-gwlb, /terraform/aws/management and /terraform/aws/cme-iam-role:
  ```
  provider "aws" {
  //  region = var.region
  //  access_key = var.access_key
  //  secret_key = var.secret_key
  }
  ```
- In case the Environment Variables are used, perform modifications described below:<br/>
  a. The next lines in main.tf file, in the provider aws resource, need to be commented:
  ```
  provider "aws" {
  //    region = var.region
  //    access_key = var.aws_access_key_ID
  //    secret_key = var.aws_secret_access_key
  }
  ```
  b. The next lines in main.tf file, in the provider aws resource, need to be commented for sub-modules /terraform/aws/autoscale, /terraform/aws/modules/management and /terraform/aws/modules/cme-iam-role:
  ```
  provider "aws" {
  //    region = var.region
  //    access_key = var.aws_access_key_ID
  //    secret_key = var.aws_secret_access_key
  }
  ```
 
## Usage
- Fill all variables in the /terraform/aws/gwlb/**terraform.tfvars** file with proper values (see below for variables descriptions).
- From a command line initialize the Terraform configuration directory:
    ```
    terraform init
    ```
- Create an execution plan:
    ```
    terraform plan
    ```
  - Create or modify the deployment:
      ```
      terraform apply
      ```
  
    - Variables are configured in /terraform/aws/qs-autoscale/**terraform.tfvars** file as follows:

      ```
      //PLEASE refer to README.md for accepted values FOR THE VARIABLES BELOW

      // --- VPC Network Configuration ---
      vpc_cidr = "10.0.0.0/16"
      public_subnets_map = {
       "us-east-1a" = 1
       "us-east-1b" = 2
       "us-east-1c" = 3
       "us-east-1d" = 4
      }
      subnets_bit_length = 8
      tgw_subnets_map = {
       "us-east-1a" = 5
       "us-east-1b" = 6
       "us-east-1c" = 7
       "us-east-1d" = 8
      }
      availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
      number_of_AZs = 2
      
      transit_gateway_attachment_subnet_1_id="subnet-3456"
      transit_gateway_attachment_subnet_2_id="subnet-4567"
      transit_gateway_attachment_subnet_3_id="subnet-5678"
      transit_gateway_attachment_subnet_4_id="subnet-6789"
      
      nat_gw_subnet_1_cidr ="10.0.13.0/24"
      nat_gw_subnet_2_cidr = "10.0.23.0/24"
      nat_gw_subnet_3_cidr = "10.0.33.0/24"
      nat_gw_subnet_4_cidr = "10.0.43.0/24"
      
      gwlbe_subnet_1_cidr = "10.0.14.0/24"
      gwlbe_subnet_2_cidr = "10.0.24.0/24"
      gwlbe_subnet_3_cidr = "10.0.34.0/24"
      gwlbe_subnet_4_cidr = "10.0.44.0/24"

        
      // --- General Settings ---
      key_name = "key-name"
      enable_volume_encryption = true
      volume_size = 100
      enable_instance_connect = false
      allow_upload_download = true
      management_server = "CP-Management-gwlb-tf"
      configuration_template = "gwlb-configuration"
      admin_shell = "/bin/bash"
        
      // --- Gateway Load Balancer Configuration ---
      gateway_load_balancer_name = "gwlb"
      target_group_name = "tg1"
      connection_acceptance_required = "false"
      enable_cross_zone_load_balancing = "true"
        
      // --- Check Point CloudGuard IaaS Security Gateways Auto Scaling Group Configuration ---
      gateway_name = "Check-Point-GW-tf"
      gateway_instance_type = "c5.xlarge"
      minimum_group_size = 2
      maximum_group_size = 10
      gateway_version = "R80.40-BYOL"
      gateway_password_hash = ""
      gateway_SICKey = ""
      gateways_provision_address_type = "private"
      enable_cloudwatch = false
        
      // --- Check Point CloudGuard IaaS Security Management Server Configuration ---
      management_deploy = true
      management_instance_type = "m5.xlarge"
      management_version = "R81.10-BYOL"
      management_password_hash = ""
      gateways_policy = "Standard"
      gateway_management = "Locally managed"
      admin_cidr = ""
      gateways_addresses = ""
        
      // --- Other parameters ---
      VolumeType = "gp3"
        
        
    ```

- Conditional creation
  - To enable cloudwatch for tgw-gwlb-master:
  ```
  enable_cloudwatch = true
  ```
  Note: enabling cloudwatch will automatically create IAM role with cloudwatch:PutMetricData permission
  - To deploy Security Management Server:
  ```
  management_deploy = true
  ```
- To tear down your resources:
    ```
    terraform destroy
    ```

## Inputs
| Name                                         | Description                                                                                                                                                                           | Type   | Allowed values                                                                                                                                                                                                                                                                                         | Default               | Required |
|----------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------|----------|
| vpc_cidr                         | The CIDR block of the VPC | string | n/a | n/a                   | yes |
| subnets_bit_length               | Number of additional bits with which to extend the vpc cidr. For example, if given a vpc_cidr ending in /16 and a subnets_bit_length value of 4, the resulting subnet address will have length /20 | number | n/a | n/a                   | yes |
| public_subnets_map                           | A map of pairs {availability-zone = subnet-suffix-number}. Each entry creates a subnet. Minimum 1 pair.  (e.g. {\"us-east-1a\" = 1} ) | map | n/a | n/a                   | yes |
| availability_zones                           | The Availability Zones (AZs) to use for the subnets in the VPC.                                                                                                                       | string | n/a                                                                                                                                                                                                                                                                                                    | n/a                   | yes      |
| Number_of_AZs                                | Number of Availability Zones to use in the VPC.                                                                                                                                       | number | n/a                                                                                                                                                                                                                                                                                                    | 2                     | yes      |
| tgw_subnets_map                              | A map of pairs {availability-zone = subnet-suffix-number} for the tgw subnets. Each entry creates a subnet. Minimum 2 pairs.  (e.g. {\"us-east-1a\" = 1} )  | map | n/a | n/a                   | yes |
| nat_gw_subnet_1_cidr                            | CIDR block for NAT subnet 1 located in the 1st Availability Zone                                                                                                                      | string | n/a                                                                                                                                                                                                                                                                        | 10.0.13.0/24          | yes      |
| nat_gw_subnet_2_cidr                            | CIDR block for NAT subnet 2 located in the 2st Availability Zone                                                                                                                      | string | n/a                                                                                                                                                                                                                                                                        | 10.0.23.0/24          | yes      |
| nat_gw_subnet_3_cidr                            | CIDR block for NAT subnet 3 located in the 3st Availability Zone                                                                                                                      | string | n/a                                                                                                                                                                                                                                                                        | 10.0.33.0/24          | yes      |
| nat_gw_subnet_4_cidr                            | CIDR block for NAT subnet 4 located in the 4st Availability Zone                                                                                                                      | string | n/a                                                                                                                                                                                                                                                                        | 10.0.43.0/24          | yes      |
| gwlbe_subnet_1_cidr | CIDR block for GWLBe subnet 1 located in the 1st Availability Zone                                                                                                                    | string | n/a                                                                                                                                                                                                                                                                        | 10.0.14.0/24          | yes      |
| gwlbe_subnet_2_cidr | CIDR block for GWLBe subnet 2 located in the 2st Availability Zone                                                                                                                    | string | n/a                                                                                                                                                                                                                                                                        | 10.0.24.0/24          | yes      |
| gwlbe_subnet_3_cidr | CIDR block for GWLBe subnet 3 located in the 3st Availability Zone                                                                                                                    | string | n/a                                                                                                                                                                                                                                                                        | 10.0.34.0/24          | yes      |
| gwlbe_subnet_4_cidr | CIDR block for GWLBe subnet 4 located in the 4st Availability Zone                                                                                                                    | string | n/a                                                                                                                                                                                                                                                                        | 10.0.44.0/24          | yes      |
| key_name                                     | The EC2 Key Pair name to allow SSH access to the instances                                                                                                                            | string | n/a                                                                                                                                                                                                                                                                                                    | n/a                   | yes      |
| enable_volume_encryption                     | Encrypt Environment instances volume with default AWS KMS key                                                                                                                         | bool   | true/false                                                                                                                                                                                                                                                                                             | true                  | no       |
| enable_instance_connect                      | Enable SSH connection over AWS web console. Supporting regions can be found [here](https://aws.amazon.com/about-aws/whats-new/2019/06/introducing-amazon-ec2-instance-connect/)       | bool   | true/false                                                                                                                                                                                                                                                                                             | false                 | no       |
| volume_size                                  | Instances volume size                                                                                                                                                                 | number | n/a                                                                                                                                                                                                                                                                                                    | 100                   | no       |
| allow_upload_download                        | Automatically download Blade Contracts and other important data. Improve product experience by sending data to Check Point                                                            | bool   | true/false                                                                                                                                                                                                                                                                                             | true                  | no       |
| management_server                | The name that represents the Security Management Server in the automatic provisioning configuration.                                                                                                                                                                  | string | n/a                                                                                                                                                                                                                                | CP-Management-gwlb-tf | yes      |
| configuration_template                       | The tag is used by the Security Management Server to automatically provision the Security Gateways. Must be up to 12 alphanumeric characters and unique for each Quick Start deployment | string | n/a                                                                                                                                                                                                                                                                                                    | gwlb-ter              | no       |
| admin_shell                                  | Set the admin shell to enable advanced command line configuration                                                                                                                     | string | - /etc/cli.sh <br/> - /bin/bash <br/> - /bin/csh <br/> - /bin/tcsh                                                                                                                                                                                                                                     | /etc/cli.sh           | no       |
| gateway_load_balancer_name                   | Load Balancer name in AWS                                                                                                                                                             | string | n/a                                                                                                                                                                                                                                                                                                    | gwlb-terraform        | yes      |
| target_group_name                            | Target Group Name. This name must be unique within your AWS account and can have a maximum of 32 alphanumeric characters and hyphens.                                                 | string | n/a                                                                                                                                                                                                                                                                                                    | tg1-terraform         | yes      |
| connection_acceptance_required               | Indicate whether requests from service consumers to create an endpoint to your service must be accepted. Default is set to false(acceptance not required).                            | bool   | true/false                                                                                                                                                                                                                                                                                             | false                 | yes      |
| enable_cross_zone_load_balancing             | Select 'true' to enable cross-az load balancing. NOTE! this may cause a spike in cross-az charges.                                                                                    | bool   | true/false                                                                                                                                                                                                                                                                                             | true                  | yes      |
| gateway_name                                 | The name tag of the Security Gateway instances. (optional)                                                                                                                            | string | n/a                                                                                                                                                                                                                                                                                                    | gwlb-terraform        | yes      |
| gateway_instance_type                        | The instance type of the Security Gateways                                                                                                                                            | string | - c5.large <br/> - c5.xlarge <br/> - c5.2xlarge <br/> - c5.4xlarge <br/> - c5.9xlarge <br/> - c5.18xlarge <br/> - c5n.large <br/> - c5n.xlarge <br/> - c5n.2xlarge <br/> - c5n.4xlarge <br/> - c5n.9xlarge <br/> - m5.large <br/> - m5.xlarge <br/> - m5.2xlarge <br/> - m5.4xlarge <br/> - m5.8xlarge | c5.xlarge             | no       |
| gateways_min_group_size                      | The minimal number of Security Gateways                                                                                                                                               | number | n/a                                                                                                                                                                                                                                                                                                    | 2                     | no       |
| gateways_max_group_size                      | The maximal number of Security Gateways                                                                                                                                               | number | n/a                                                                                                                                                                                                                                                                                                    | 10                    | no       |
| gateway_version                              | Gateway version and license                                                                                                                                                           | string | - R80.40-BYOL <br/> - R80.40-PAYG-NGTP <br/> - R80.40-PAYG-NGTX                                                                                                      | R80.40-BYOL           | no       |
| gateway_password_hash                        | (Optional) Admin user's password hash (use command 'openssl passwd -6 PASSWORD' to get the PASSWORD's hash)                                                                           | string | n/a                                                                                                                                                                                                                                                                                                    | ""                    | no       |
| gateway_SICKey                               | The Secure Internal Communication key for trusted connection between Check Point components. Choose a random string consisting of at least 8 alphanumeric characters                  | string | n/a                                                                                                                                                                                                                                                                                                    | n/a                   | yes      |
| enable_cloudwatch                            | Report Check Point specific CloudWatch metrics                                                                                                                                        | bool   | true/false                                                                                                                                                                                                                                                                                             | false                 | no       |
| gateways_provision_address_type              | Determines if the gateways are provisioned using their private or public address.                                                                                                     | string | - private <br/> - public                                                                                                                                                                                                                                                                               | private               | no |
| management_deploy                            | Select 'false' to use an existing Security Management Server or to deploy one later and to ignore the other parameters of this section                                                | bool   | true/false                                                                                                                                                                                                                                                                                             | true                  | no       |
| management_instance_type                     | The EC2 instance type of the Security Management Server                                                                                                                               | string | - m5.large <br/> - m5.xlarge <br/> - m5.2xlarge <br/> - m5.4xlarge <br/> - m5.12xlarge <br/> - m5.24xlarge                                                                                                                                                                                             | m5.xlarge             | no       |
| management_version                           | The license to install on the Security Management Server                                                                                                                              | string | - R80.40-BYOL <br/> - R80.40-PAYG <br/> - R81-BYOL <br/> - R81-PAYG <br/> - R81.10-BYOL <br/> - R81.10-PAYG                                                                                                                                                                                            | R80.40-PAYG           | no       |
| management_password_hash                     | (Optional) Admin user's password hash (use command 'openssl passwd -6 PASSWORD' to get the PASSWORD's hash)                                                                           | string | n/a                                                                                                                                                                                                                                                                                                    | ""                    | no       |
| gateways_policy                              | The name of the Security Policy package to be installed on the gateways in the Security Gateways Auto Scaling group                                                                   | string | n/a                                                                                                                                                                                                                                                                                                    | Standard              | no       |
| gateway_management                           | Select 'Over the internet' if any of the gateways you wish to manage are not directly accessed via their private IP address.                                                          | string | - Locally managed <br/> - Over the internet                                                                                                                                                                                                                                                            | Locally managed       | no       |
| admin_cidr                                   | (CIDR) Allow web, ssh, and graphical clients only from this network to communicate with the Management Server                                                                         | string | valid CIDR                                                                                                                                                                                                                                                                                             | n/a                   | no       |
| gateway_addresses                            | (CIDR) Allow gateways only from this network to communicate with the Management Server                                                                                                | string | valid CIDR                                                                                                                                                                                                                                                                                             | n/a                   | no       |
| volume_type                                  | General Purpose SSD Volume Type                                                                                                                                                       | string | - gp3 <br/> - gp2                                                                                                                                                                                                                                                                                      | gp3                   | no       |


## Outputs
| Name  | Description                                                 |
| ------------- |-------------------------------------------------------------|
| managment_public_ip  | The deployed Security Management AWS instance public IP                               |
| load_balancer_url  | The URL of the external Load Balancer                                                 |
| template_name  | Name of a gateway configuration template in the automatic provisioning configuration. |
| controller_name  | The controller name in CME.                                                           |
| gwlb_name  | The name of the deployed Gateway Load Balancer                                        |
| gwlb_service_name  | The service name for the deployed Gateway Load Balancer                               |
| gwlb_arn  | The arn for the deployed Gateway Load Balancer                                        |



## Revision History
In order to check the template version, please refer to [sk116585](https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk116585)

| Template Version | Description                                                                                                               |
| ---------------- |---------------------------------------------------------------------------------------------------------------------------|
| 20220414 | First release of Check Point CloudGuard Network Gateway Load Balancer for Transit Gateway Master Terraform module for AWS |



## License

This project is licensed under the MIT License - see the [LICENSE](../../LICENSE) file for details