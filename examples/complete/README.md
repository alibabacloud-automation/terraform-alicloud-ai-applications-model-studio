# Complete Example

This example demonstrates the complete usage of the BaiLian AI Application module, creating a full infrastructure stack including VPC, VSwitch, Security Group, and ECS instance with BaiLian application setup.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Required Variables

The following variables need to be set:

- `bailian_api_key`: Your BaiLian API key
- `ecs_instance_password`: Password for the ECS instance (8-30 chars, with uppercase, lowercase, numbers and special chars)

## Optional Variables

- `common_name_prefix`: Prefix for resource names (default: "BaiLian")
- `region`: Alibaba Cloud region (default: "cn-hangzhou")
- `image_id`: ECS instance image (default: "aliyun_3_9_x64_20G_alibase_20231219.vhd")
- `instance_type`: ECS instance type (default: "ecs.e-c1m2.large")
- `vpc_cidr_block`: VPC network range (default: "192.168.0.0/16")
- `vswitch_cidr_block`: VSwitch network range (default: "192.168.0.0/24")
- `system_disk_category`: Disk type (default: "cloud_essd")
- `system_disk_size`: Disk size in GB (default: 40)
- `internet_max_bandwidth_out`: Bandwidth in Mbps (default: 5)