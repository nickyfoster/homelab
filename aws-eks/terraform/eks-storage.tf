# EBS CSI
# module "ebs_csi_driver_controller" {
#   source  = "DrFaust92/ebs-csi-driver/kubernetes"
#   version = "3.5.0"

#   oidc_url = module.eks.cluster_oidc_issuer_url
#   tags     = local.tags
# }


# # FSx NetApp ONTAP
# resource "random_string" "fsx_password" {
#   length           = 8
#   min_lower        = 1
#   min_numeric      = 1
#   min_special      = 1
#   min_upper        = 1
#   numeric          = true
#   special          = true
#   override_special = "!"
# }

# resource "aws_fsx_ontap_file_system" "eksfs" {
#   storage_capacity    = 2048
#   subnet_ids          = module.vpc.public_subnets
#   deployment_type     = "MULTI_AZ_1"
#   throughput_capacity = 512
#   preferred_subnet_id = module.vpc.public_subnets[0]
#   security_group_ids  = [aws_security_group.fsx_sg.id]
#   fsx_admin_password  = random_string.fsx_password.result
#   route_table_ids     = module.vpc.public_route_table_ids
#   tags                = local.tags
# }

# resource "aws_fsx_ontap_storage_virtual_machine" "ekssvm" {
#   file_system_id = aws_fsx_ontap_file_system.eksfs.id
#   name           = "ekssvm"
#   tags           = local.tags
# }

# resource "aws_security_group" "fsx_sg" {
#   name_prefix = "security group for fsx access"
#   vpc_id      = module.vpc.vpc_id
#   tags        = local.tags
# }

# resource "aws_security_group_rule" "fsx_sg_inbound" {
#   description       = "allow inbound traffic to eks"
#   from_port         = 0
#   protocol          = "-1"
#   to_port           = 0
#   security_group_id = aws_security_group.fsx_sg.id
#   type              = "ingress"
#   cidr_blocks       = [var.vpc_cidr]
# }

# resource "aws_security_group_rule" "fsx_sg_outbound" {
#   description       = "allow outbound traffic to anywhere"
#   from_port         = 0
#   protocol          = "-1"
#   security_group_id = aws_security_group.fsx_sg.id
#   to_port           = 0
#   type              = "egress"
#   cidr_blocks       = ["0.0.0.0/0"]
# }


## https://aws.amazon.com/blogs/containers/how-to-run-a-multi-az-stateful-application-on-eks-with-aws-fsx-for-netapp-ontap/

# !TODO Deploy Trident chart
# $ curl -L -o trident-installer-21.10.1.tar.gz https://github.com/NetApp/trident/releases/download/v21.10.1/trident-installer-21.10.1.tar.gz


# !TODO Create svm_secret.yaml


# !TODO Create the Trident backend backend-ontap-nas.yaml
# Change directory to the eks folder of your cloned repo; note the backend-ontap-nas.yaml file. Replace the managementLIF and dataLIF with the correct details and save the file. 
# (Refer to the Trident’s documentation for more details when considering which one to use based on your application.)
# Note: ManagementLIF can be found using the Amazon FSx console, as demonstrated in the following image, highlighted as Management DNS name.


# !TODO Create storage-class-csi-nas.yaml