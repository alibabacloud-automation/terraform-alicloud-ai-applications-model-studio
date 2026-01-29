provider "alicloud" {
  region = var.region
}

# Get available zones
data "alicloud_zones" "available" {
  available_instance_type = var.instance_type
}

# Call the module
module "bailian_app" {
  source = "../../"

  vpc_config = {
    cidr_block = var.vpc_cidr_block
    vpc_name   = var.common_name_prefix
  }

  vswitch_config = {
    cidr_block   = var.vswitch_cidr_block
    zone_id      = data.alicloud_zones.available.zones[0].id
    vswitch_name = "${var.common_name_prefix}-vswitch"
  }

  security_group_config = {
    security_group_name = "${var.common_name_prefix}-SecurityGroup"
  }

  security_group_rule_config = [
    {
      type        = "ingress"
      ip_protocol = "tcp"
      nic_type    = "intranet"
      policy      = "accept"
      port_range  = "80/80"
      priority    = 1
      cidr_ip     = var.vswitch_cidr_block
    }
  ]

  instance_config = {
    image_id                   = var.image_id
    instance_type              = var.instance_type
    system_disk_category       = var.system_disk_category
    system_disk_size           = var.system_disk_size
    internet_max_bandwidth_out = var.internet_max_bandwidth_out
    password                   = var.ecs_instance_password
  }

  bailian_config = {
    api_key = var.bailian_api_key
  }

  ecs_command_config = {
    name        = "setup-bailian-app"
    working_dir = "/root"
    type        = "RunShellScript"
    timeout     = 3600
  }

  ecs_invocation_config = {
    create_timeout = "15m"
  }
}