阿里云AI应用Terraform模块

================================================ 

# terraform-alicloud-ai-applications-model-studio

[English](https://github.com/alibabacloud-automation/terraform-alicloud-ai-applications-model-studio/blob/main/README.md) | 简体中文

基于阿里云模型工作室创建AI应用基础设施的Terraform模块。该模块提供必要的云资源，包括VPC、ECS实例、安全组和自动化设置脚本，使用百炼API高效构建AI智能体和工作流应用。

## 使用方法

该模块帮助您基于阿里云模型工作室快速高效地构建AI应用。您需要提供百炼API密钥来访问模型服务。该模块创建完整的基础设施堆栈，包括网络、计算资源和安全配置。

```terraform
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_images" "default" {
  name_regex  = "^aliyun_3_9_x64_20G_alibase_*"
  most_recent = true
  owners      = "system"
}

module "ai_application" {
  source = "alibabacloud-automation/ai-applications-model-studio/alicloud"
  
  common_name      = "MyAIApp"
  bailian_api_key = var.bailian_api_key

  vpc_config = {
    cidr_block = "192.168.0.0/16"
    vpc_name   = "ai-app-vpc"
  }

  vswitch_config = {
    cidr_block   = "192.168.0.0/24"
    zone_id      = data.alicloud_zones.default.zones[0].id
    vswitch_name = "ai-app-vswitch"
  }

  instance_config = {
    image_id                   = data.alicloud_images.default.images[0].id
    instance_type              = "ecs.e-c1m2.large"
    system_disk_category       = "cloud_essd"
    system_disk_size           = 40
    internet_max_bandwidth_out = 5
    password                   = var.ecs_password
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-ai-applications-model-studio/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.210.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.210.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ecs_command.run_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invoke_script](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_ram_access_key.ram_access_key](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_access_key) | resource |
| [alicloud_ram_user.ram_user](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user) | resource |
| [alicloud_ram_user_policy_attachment.attach_policy_to_user](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user_policy_attachment) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_app_port](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arms_config"></a> [arms\_config](#input\_arms\_config) | ARMS (Application Real-Time Monitoring Service) configuration | <pre>object({<br>    app_name    = string<br>    is_public   = bool<br>    license_key = string<br>  })</pre> | <pre>{<br>  "app_name": "llm_app",<br>  "is_public": true,<br>  "license_key": null<br>}</pre> | no |
| <a name="input_bailian_config"></a> [bailian\_config](#input\_bailian\_config) | Bailian (DashScope) API configuration | <pre>object({<br>    api_key = string<br>  })</pre> | <pre>{<br>  "api_key": null<br>}</pre> | no |
| <a name="input_custom_deployment_script"></a> [custom\_deployment\_script](#input\_custom\_deployment\_script) | Custom deployment script for AI application. If not provided, the default script will be used | `string` | `null` | no |
| <a name="input_ecs_command_config"></a> [ecs\_command\_config](#input\_ecs\_command\_config) | ECS command configuration for deploying AI application | <pre>object({<br>    name        = optional(string, "DeployAIAppCommand")<br>    working_dir = string<br>    type        = string<br>    timeout     = number<br>  })</pre> | <pre>{<br>  "timeout": 3600,<br>  "type": "RunShellScript",<br>  "working_dir": "/root"<br>}</pre> | no |
| <a name="input_ecs_invocation_config"></a> [ecs\_invocation\_config](#input\_ecs\_invocation\_config) | ECS invocation configuration | <pre>object({<br>    create_timeout = string<br>  })</pre> | <pre>{<br>  "create_timeout": "5m"<br>}</pre> | no |
| <a name="input_enable_ecs_invocation"></a> [enable\_ecs\_invocation](#input\_enable\_ecs\_invocation) | Whether to enable ECS command invocation for AI application deployment. Set to false to skip the deployment step | `bool` | `true` | no |
| <a name="input_instance_config"></a> [instance\_config](#input\_instance\_config) | ECS instance configuration. The 'image\_id', 'instance\_type', 'system\_disk\_category', and 'password' attributes are required | <pre>object({<br>    image_id                   = string<br>    instance_type              = string<br>    system_disk_category       = string<br>    password                   = string<br>    instance_name              = optional(string, null)<br>    internet_max_bandwidth_out = optional(number, 5)<br>  })</pre> | <pre>{<br>  "image_id": null,<br>  "instance_type": "ecs.t6-c1m2.large",<br>  "password": null,<br>  "system_disk_category": "cloud_essd"<br>}</pre> | no |
| <a name="input_ram_policy_attachment_config"></a> [ram\_policy\_attachment\_config](#input\_ram\_policy\_attachment\_config) | RAM policy attachment configuration | <pre>object({<br>    policy_type = string<br>    policy_name = string<br>  })</pre> | <pre>{<br>  "policy_name": "AliyunLogFullAccess",<br>  "policy_type": "System"<br>}</pre> | no |
| <a name="input_ram_user_config"></a> [ram\_user\_config](#input\_ram\_user\_config) | RAM user configuration for service access authorization | <pre>object({<br>    name = optional(string, null)<br>  })</pre> | `{}` | no |
| <a name="input_security_group_config"></a> [security\_group\_config](#input\_security\_group\_config) | Security group configuration | <pre>object({<br>    security_group_name = optional(string, null)<br>    description         = optional(string, "Security group for AI application observability system")<br>  })</pre> | <pre>{<br>  "description": "Security group for AI application observability system"<br>}</pre> | no |
| <a name="input_security_group_rule_config"></a> [security\_group\_rule\_config](#input\_security\_group\_rule\_config) | Security group rule configuration for allowing access to application port | <pre>object({<br>    type        = string<br>    ip_protocol = string<br>    nic_type    = string<br>    policy      = string<br>    port_range  = string<br>    priority    = number<br>    cidr_ip     = string<br>  })</pre> | <pre>{<br>  "cidr_ip": "192.168.0.0/24",<br>  "ip_protocol": "tcp",<br>  "nic_type": "intranet",<br>  "policy": "accept",<br>  "port_range": "8000/8000",<br>  "priority": 1,<br>  "type": "ingress"<br>}</pre> | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | VPC configuration. The 'cidr\_block' attribute is required | <pre>object({<br>    cidr_block = string<br>    vpc_name   = optional(string, null)<br>  })</pre> | <pre>{<br>  "cidr_block": "192.168.0.0/16"<br>}</pre> | no |
| <a name="input_vswitch_config"></a> [vswitch\_config](#input\_vswitch\_config) | VSwitch configuration. The 'cidr\_block' and 'zone\_id' attributes are required | <pre>object({<br>    cidr_block   = string<br>    zone_id      = string<br>    vswitch_name = optional(string, null)<br>  })</pre> | <pre>{<br>  "cidr_block": "192.168.0.0/24",<br>  "zone_id": null<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_access_info"></a> [application\_access\_info](#output\_application\_access\_info) | Information for accessing the deployed AI application |
| <a name="output_ecs_command_id"></a> [ecs\_command\_id](#output\_ecs\_command\_id) | The ID of the ECS command for AI application deployment |
| <a name="output_ecs_invocation_id"></a> [ecs\_invocation\_id](#output\_ecs\_invocation\_id) | The ID of the ECS command invocation |
| <a name="output_ecs_login_address"></a> [ecs\_login\_address](#output\_ecs\_login\_address) | The ECS workbench login address for the deployed instance |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The ID of the ECS instance |
| <a name="output_instance_private_ip"></a> [instance\_private\_ip](#output\_instance\_private\_ip) | The private IP address of the ECS instance |
| <a name="output_instance_public_ip"></a> [instance\_public\_ip](#output\_instance\_public\_ip) | The public IP address of the ECS instance |
| <a name="output_ram_access_key_id"></a> [ram\_access\_key\_id](#output\_ram\_access\_key\_id) | The access key ID of the RAM user |
| <a name="output_ram_access_key_secret"></a> [ram\_access\_key\_secret](#output\_ram\_access\_key\_secret) | The access key secret of the RAM user |
| <a name="output_ram_user_name"></a> [ram\_user\_name](#output\_ram\_user\_name) | The name of the RAM user |
| <a name="output_region"></a> [region](#output\_region) | The region where resources are deployed |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vswitch_id"></a> [vswitch\_id](#output\_vswitch\_id) | The ID of the VSwitch |
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)