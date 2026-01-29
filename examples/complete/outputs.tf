output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.bailian_app.vpc_id
}

output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = module.bailian_app.vswitch_id
}

output "security_group_id" {
  description = "The ID of the Security Group"
  value       = module.bailian_app.security_group_id
}

output "ecs_instance_id" {
  description = "The ID of the ECS instance"
  value       = module.bailian_app.ecs_instance_id
}

output "ecs_instance_public_ip" {
  description = "The public IP address of the ECS instance"
  value       = module.bailian_app.ecs_instance_public_ip
}

output "web_url" {
  description = "Web access URL for the BaiLian application"
  value       = module.bailian_app.web_url
}

output "ecs_login_address" {
  description = "ECS login address through Alibaba Cloud console"
  value       = module.bailian_app.ecs_login_address
}