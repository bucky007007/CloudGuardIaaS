//#PLEASE refer to the README.md for accepted values FOR THE VARIABLES BELOW
client_secret                   = "PLEASE ENTER CLIENT SECRET"                                     # "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
client_id                       = "PLEASE ENTER CLIENT ID"                                         # "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
tenant_id                       = "PLEASE ENTER TENANT ID"                                         # "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
subscription_id                 = "PLEASE ENTER SUBSCRIPTION ID"                                   # "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
source_image_vhd_uri            = "PLEASE ENTER SOURCE IMAGE VHD URI OR noCustomUri"               # "noCustomUri"
resource_group_name             = "PLEASE ENTER RESOURCE GROUP NAME"                               # "checkpoint-vmss-terraform"
vmss_name                       = "PLEASE ENTER SCALE SET NAME"                                    # "checkpoint-vmss-terraform"
location                        = "PLEASE ENTER LOCATION"                                          # "eastus"
vnet_name                       = "PLEASE ENTER VIRTUAL NETWORK NAME"                              # "checkpoint-vmss-vnet"
address_space                   = "PLEASE ENTER VIRTUAL NETWORK ADDRESS SPACE"                     # "10.0.0.0/16"
subnet_prefixes                 = "PLEASE ENTER ADDRESS PREFIXES FOR SUBNETS"                      # ["10.0.1.0/24","10.0.2.0/24"]
backend_lb_IP_address           = "PLEASE ENTER BACKEND LB IP ADDRESS POSITIONAL NUMBER"           # 4
admin_password                  = "PLEASE ENTER ADMIN PASSWORD"                                    # "xxxxxxxxxxxx"
sic_key                         = "PLEASE ENTER SIC KEY"                                           # "xxxxxxxxxxxx"
vm_size                         = "PLEASE ENTER VM SIZE"                                           # "Standard_D3_v2"
disk_size                       = "PLEASE ENTER DISK SIZE"                                         # "110"
vm_os_sku                       = "PLEASE ENTER VM SKU"                                            # "sg-byol"
vm_os_offer                     = "PLEASE ENTER VM OFFER"                                          # "check-point-cg-r8110"
os_version                      = "PLEASE ENTER GAIA OS VERSION"                                   # "R8110"
bootstrap_script                = "PLEASE ENTER CUSTOM SCRIPT OR LEAVE EMPTY DOUBLE QUOTES"        # "touch /home/admin/bootstrap.txt; echo 'hello_world' > /home/admin/bootstrap.txt"
allow_upload_download           = "PLEASE ENTER true or false"                                     # true
authentication_type             = "PLEASE ENTER AUTHENTICATION TYPE"                               # "Password"
availability_zones_num          = "PLEASE ENTER NUMBER OF AVAILABILITY ZONES"                      # "1"
minimum_number_of_vm_instances  = "PLEASE ENTER MINIMUM NUMBER OF VM INSTANCES"                    # 2
maximum_number_of_vm_instances  = "PLEASE ENTER MAXIMUM NUMBER OF VM INSTANCES"                    # 10
management_name                 = "PLEASE ENTER MANAGEMENT NAME"                                   # "mgmt"
management_IP                   = "PLEASE ENTER MANAGEMENT IP"                                     # "13.92.42.181"
management_interface            = "PLEASE ENTER MANAGEMENT INTERFACE"                              # "eth1-private"
configuration_template_name     = "PLEASE ENTER CONFIGURATION TEMPLATE NAME"                       # "vmss_template"
notification_email              = "PLEASE ENTER NOTIFICATION MAIL OR LEAVE EMPTY DOUBLE QUOTES"     # ""
frontend_load_distribution      = "PLEASE ENTER EXTERNAL LOAD BALANCER SESSION PERSISTENCE"        # "Default"
backend_load_distribution       = "PLEASE ENTER INTERNAL LOAD BALANCER SESSION PERSISTENCE"        # "Default"
enable_custom_metrics           = "PLEASE ENTER true or false"                                     # true
enable_floating_ip              = "PLEASE ENTER true or false"                                     # false
deployment_mode                 = "PLEASE ENTER DEPLOYMENT MODE"                                   # "Standard"
admin_shell                     = "PLEASE ETNER ADMIN SHELL"                                       # "/etc/cli.sh"
serial_console_password_hash    = "PLEASE ENTER SERIAL CONSOLE PASSWORD HASH"                      # "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
maintenance_mode_password_hash  = "PLEASE ENTER MAINTENANCE MODE PASSWORD HASH"                    # "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"