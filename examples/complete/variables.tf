variable "region" {
  description = "The Alibaba Cloud region where resources will be created"
  type        = string
  default     = "cn-zhangjiakou"
}

variable "common_name_prefix" {
  description = "Common name prefix for resources"
  type        = string
  default     = "BaiLian"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "vswitch_cidr_block" {
  description = "The CIDR block for the VSwitch"
  type        = string
  default     = "192.168.0.0/24"
}

variable "image_id" {
  description = "The image ID for the ECS instance"
  type        = string
  default     = "aliyun_3_9_x64_20G_alibase_20231219.vhd"
}

variable "instance_type" {
  description = "The instance type for the ECS instance"
  type        = string
  default     = "ecs.e-c1m2.large"
}

variable "system_disk_category" {
  description = "The system disk category for the ECS instance"
  type        = string
  default     = "cloud_essd"
}

variable "system_disk_size" {
  description = "The system disk size for the ECS instance (in GB)"
  type        = number
  default     = 40
}

variable "internet_max_bandwidth_out" {
  description = "The maximum outbound bandwidth for the ECS instance (in Mbps)"
  type        = number
  default     = 5
}

variable "ecs_instance_password" {
  description = "The password for the ECS instance login. Length must be 8-30 characters and contain uppercase letters, lowercase letters, numbers, and special characters."
  type        = string
  sensitive   = true
}

variable "bailian_api_key" {
  description = "BaiLian API Key. You need to enable BaiLian model service first and then get the API Key. For more details: https://help.aliyun.com/zh/model-studio/developer-reference/get-api-key"
  type        = string
  sensitive   = true
}