output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.vpc.id
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = alicloud_vpc.vpc.vpc_name
}

output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = alicloud_vswitch.vswitch.id
}

output "vswitch_name" {
  description = "The name of the VSwitch"
  value       = alicloud_vswitch.vswitch.vswitch_name
}

output "security_group_id" {
  description = "The ID of the Security Group"
  value       = alicloud_security_group.security_group.id
}

output "security_group_name" {
  description = "The name of the Security Group"
  value       = alicloud_security_group.security_group.security_group_name
}

output "ecs_instance_id" {
  description = "The ID of the ECS instance"
  value       = alicloud_instance.ecs_instance.id
}

output "ecs_instance_public_ip" {
  description = "The public IP address of the ECS instance"
  value       = alicloud_instance.ecs_instance.public_ip
}

output "ecs_instance_private_ip" {
  description = "The private IP address of the ECS instance"
  value       = alicloud_instance.ecs_instance.primary_ip_address
}

output "web_url" {
  description = "Web access URL for the BaiLian application"
  value       = "http://${alicloud_instance.ecs_instance.public_ip}"
}

output "ecs_login_address" {
  description = "ECS login address through Alibaba Cloud console"
  value       = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${data.alicloud_regions.current.regions[0].id}&instanceId=${alicloud_instance.ecs_instance.id}"
}

output "ecs_command_id" {
  description = "The ID of the ECS command for BaiLian setup"
  value       = alicloud_ecs_command.run_script.id
}

output "ecs_invocation_id" {
  description = "The ID of the ECS command invocation"
  value       = alicloud_ecs_invocation.run_command.id
}