Alibaba Cloud AI Applications Terraform Module Based on Model Studio

================================================ 

# terraform-alicloud-ai-applications-model-studio

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-ai-applications-model-studio/blob/main/README-CN.md)

This Terraform module is used to implement the solution [Efficiently build AI agents and workflow applications](https://www.aliyun.com/solution/tech-solution/build-ai-applications-based-on-alibaba-cloud-model-studio), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS), and automated setup of AI applications using Alibaba Cloud Model Studio. This module provides a complete infrastructure foundation for building and deploying AI-powered applications with automated configuration and deployment scripts.

## Usage

This module sets up a complete environment for AI applications based on Alibaba Cloud Model Studio, including VPC network infrastructure, ECS instances, and automated application deployment.

```terraform
provider "alicloud" {
  region = "cn-hangzhou"
}

module "ai_application" {
  source = "alibabacloud-automation/ai-applications-model-studio/alicloud"

  vpc_config = {
    cidr_block = "10.0.0.0/8"
    vpc_name   = "MyAIVPC"
  }

  vswitch_config = {
    cidr_block = "10.1.0.0/16"
    zone_id    = "cn-hangzhou-h"
    vswitch_name = "MyAIVSwitch"
  }

  security_group_config = {
    security_group_name = "MyAISecurityGroup"
  }

  security_group_rule_config = {
    type        = "ingress"
    ip_protocol = "tcp"
    nic_type    = "intranet"
    policy      = "accept"
    port_range  = "80/80"
    priority    = 1
    cidr_ip     = "0.0.0.0/0"
  }

  instance_config = {
    image_id                   = "centos_8_4_x64_20G_alibase_20230228.vhd"
    instance_type              = "ecs.c6.large"
    system_disk_category       = "cloud_efficiency"
    system_disk_size           = 40
    internet_max_bandwidth_out = 100
    password                   = "YourSecurePassword123!"
  }

  bailian_config = {
    api_key = "your-bailian-api-key"
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
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-ai-applications-model-studio/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.220.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.269.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ecs_command.run_script](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.run_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bailian_config"></a> [bailian\_config](#input\_bailian\_config) | The parameters for BaiLian API configuration. The attribute 'api\_key' is required. | <pre>object({<br>    api_key = string<br>  })</pre> | <pre>{<br>  "api_key": null<br>}</pre> | no |
| <a name="input_custom_bailian_setup_script"></a> [custom\_bailian\_setup\_script](#input\_custom\_bailian\_setup\_script) | Custom BaiLian setup script (base64 encoded). If not provided, the default script will be used. | `string` | `null` | no |
| <a name="input_ecs_command_config"></a> [ecs\_command\_config](#input\_ecs\_command\_config) | The parameters of ECS command for BaiLian setup. | <pre>object({<br>    name        = optional(string, "setup-bailian-app")<br>    working_dir = optional(string, "/root")<br>    type        = optional(string, "RunShellScript")<br>    timeout     = optional(number, 3600)<br>  })</pre> | `{}` | no |
| <a name="input_ecs_invocation_config"></a> [ecs\_invocation\_config](#input\_ecs\_invocation\_config) | The parameters of ECS command invocation. | <pre>object({<br>    create_timeout = optional(string, "15m")<br>  })</pre> | `{}` | no |
| <a name="input_instance_config"></a> [instance\_config](#input\_instance\_config) | The parameters of ECS instance. The attributes 'image\_id', 'instance\_type', 'system\_disk\_category', 'system\_disk\_size' and 'password' are required. | <pre>object({<br>    image_id                   = string<br>    instance_type              = string<br>    system_disk_category       = string<br>    system_disk_size           = number<br>    internet_max_bandwidth_out = optional(number, 0)<br>    password                   = string<br>  })</pre> | n/a | yes |
| <a name="input_security_group_config"></a> [security\_group\_config](#input\_security\_group\_config) | The parameters of Security Group. | <pre>object({<br>    security_group_name = optional(string, "BaiLian-SecurityGroup_1")<br>  })</pre> | `{}` | no |
| <a name="input_security_group_rule_config"></a> [security\_group\_rule\_config](#input\_security\_group\_rule\_config) | The parameters of Security Group Rules for HTTP access. A list of objects defining security group rules. | <pre>list(object({<br>    type        = optional(string, "ingress")<br>    ip_protocol = optional(string, "tcp")<br>    nic_type    = optional(string, "intranet")<br>    policy      = optional(string, "accept")<br>    port_range  = optional(string, "80/80")<br>    priority    = optional(number, 1)<br>    cidr_ip     = optional(string, "0.0.0.0/0")<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | The parameters of VPC. The attribute 'cidr\_block' is required. | <pre>object({<br>    cidr_block = string<br>    vpc_name   = optional(string, "BaiLian-VPC")<br>  })</pre> | n/a | yes |
| <a name="input_vswitch_config"></a> [vswitch\_config](#input\_vswitch\_config) | The parameters of VSwitch. The attributes 'cidr\_block' and 'zone\_id' are required. | <pre>object({<br>    cidr_block   = string<br>    zone_id      = string<br>    vswitch_name = optional(string, "BaiLian-vsw_001")<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_command_id"></a> [ecs\_command\_id](#output\_ecs\_command\_id) | The ID of the ECS command for BaiLian setup |
| <a name="output_ecs_instance_id"></a> [ecs\_instance\_id](#output\_ecs\_instance\_id) | The ID of the ECS instance |
| <a name="output_ecs_instance_private_ip"></a> [ecs\_instance\_private\_ip](#output\_ecs\_instance\_private\_ip) | The private IP address of the ECS instance |
| <a name="output_ecs_instance_public_ip"></a> [ecs\_instance\_public\_ip](#output\_ecs\_instance\_public\_ip) | The public IP address of the ECS instance |
| <a name="output_ecs_invocation_id"></a> [ecs\_invocation\_id](#output\_ecs\_invocation\_id) | The ID of the ECS command invocation |
| <a name="output_ecs_login_address"></a> [ecs\_login\_address](#output\_ecs\_login\_address) | ECS login address through Alibaba Cloud console |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the Security Group |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The name of the Security Group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | The name of the VPC |
| <a name="output_vswitch_id"></a> [vswitch\_id](#output\_vswitch\_id) | The ID of the VSwitch |
| <a name="output_vswitch_name"></a> [vswitch\_name](#output\_vswitch\_name) | The name of the VSwitch |
| <a name="output_web_url"></a> [web\_url](#output\_web\_url) | Web access URL for the BaiLian application |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)