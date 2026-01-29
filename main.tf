# Get current region information for reference
data "alicloud_regions" "current" {
  current = true
}

# VPC Resource
resource "alicloud_vpc" "vpc" {
  cidr_block = var.vpc_config.cidr_block
  vpc_name   = var.vpc_config.vpc_name
}

# VSwitch Resource
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vswitch_config.cidr_block
  zone_id      = var.vswitch_config.zone_id
  vswitch_name = var.vswitch_config.vswitch_name
}

# Security Group Resource
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = var.security_group_config.security_group_name
}

# Security Group Rules for HTTP access
resource "alicloud_security_group_rule" "default" {
  for_each          = { for i, rule in var.security_group_rule_config : "rule-${i}" => rule }
  type              = each.value.type
  ip_protocol       = each.value.ip_protocol
  nic_type          = each.value.nic_type
  policy            = each.value.policy
  port_range        = each.value.port_range
  priority          = each.value.priority
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = each.value.cidr_ip
}

# ECS Instance Resource
resource "alicloud_instance" "ecs_instance" {
  vpc_id                     = alicloud_vpc.vpc.id
  vswitch_id                 = alicloud_vswitch.vswitch.id
  security_groups            = [alicloud_security_group.security_group.id]
  image_id                   = var.instance_config.image_id
  instance_type              = var.instance_config.instance_type
  system_disk_category       = var.instance_config.system_disk_category
  system_disk_size           = var.instance_config.system_disk_size
  internet_max_bandwidth_out = var.instance_config.internet_max_bandwidth_out
  password                   = var.instance_config.password
}

# Default setup script for BaiLian application
locals {
  default_bailian_setup_script = base64encode(<<-SCRIPT
#!/bin/bash
cat << "PROFILE_EOF" >> ~/.bash_profile
export BAILIAN_API_KEY=${var.bailian_config.api_key}
export ROS_DEPLOY=true
PROFILE_EOF

source ~/.bash_profile

curl -fsSL https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/install-script/create-ai-app-via-bailian/install.sh | bash
SCRIPT
  )
}

# ECS Command Resource for BaiLian setup
resource "alicloud_ecs_command" "run_script" {
  name            = var.ecs_command_config.name
  command_content = var.custom_bailian_setup_script != null ? var.custom_bailian_setup_script : local.default_bailian_setup_script
  working_dir     = var.ecs_command_config.working_dir
  type            = var.ecs_command_config.type
  timeout         = var.ecs_command_config.timeout
}

# ECS Command Invocation
resource "alicloud_ecs_invocation" "run_command" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.run_script.id

  timeouts {
    create = var.ecs_invocation_config.create_timeout
  }
}