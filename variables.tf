variable "vpc_config" {
  description = "The parameters of VPC. The attribute 'cidr_block' is required."
  type = object({
    cidr_block = string
    vpc_name   = optional(string, "BaiLian-VPC")
  })
}

variable "vswitch_config" {
  description = "The parameters of VSwitch. The attributes 'cidr_block' and 'zone_id' are required."
  type = object({
    cidr_block   = string
    zone_id      = string
    vswitch_name = optional(string, "BaiLian-vsw_001")
  })
}

variable "security_group_config" {
  description = "The parameters of Security Group."
  type = object({
    security_group_name = optional(string, "BaiLian-SecurityGroup_1")
  })
  default = {}
}

variable "security_group_rule_config" {
  description = "The parameters of Security Group Rules for HTTP access. A list of objects defining security group rules."
  type = list(object({
    type        = optional(string, "ingress")
    ip_protocol = optional(string, "tcp")
    nic_type    = optional(string, "intranet")
    policy      = optional(string, "accept")
    port_range  = optional(string, "80/80")
    priority    = optional(number, 1)
    cidr_ip     = optional(string, "0.0.0.0/0")
  }))
  default = []
}

variable "instance_config" {
  description = "The parameters of ECS instance. The attributes 'image_id', 'instance_type', 'system_disk_category', 'system_disk_size' and 'password' are required."
  type = object({
    image_id                   = string
    instance_type              = string
    system_disk_category       = string
    system_disk_size           = number
    internet_max_bandwidth_out = optional(number, 0)
    password                   = string
  })
}

variable "bailian_config" {
  description = "The parameters for BaiLian API configuration. The attribute 'api_key' is required."
  type = object({
    api_key = string
  })
  default = {
    api_key = null
  }
}

variable "ecs_command_config" {
  description = "The parameters of ECS command for BaiLian setup."
  type = object({
    name        = optional(string, "setup-bailian-app")
    working_dir = optional(string, "/root")
    type        = optional(string, "RunShellScript")
    timeout     = optional(number, 3600)
  })
  default = {}
}

variable "ecs_invocation_config" {
  description = "The parameters of ECS command invocation."
  type = object({
    create_timeout = optional(string, "15m")
  })
  default = {}
}

variable "custom_bailian_setup_script" {
  description = "Custom BaiLian setup script (base64 encoded). If not provided, the default script will be used."
  type        = string
  default     = null
}