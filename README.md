### Comandos Terraform

* terraform init

* terraform plan
* terraform plan -out plan.out
* terraform plan -out plan.out -destroy

* terraform show plan.out
* terraform fmt

* terraform apply
* terraform apply -destroy
* terraform apply plan.out

* terraform destroy

### Blocos Terraform


### Variables, Locals and Outputs

```
variable "enrironment" {
    ...
}
```

#### Variable parameters: 

- default - A default value which then makes the variable optional.
- type - This argument specifies what value types are accepted for the variable.
- description - This specifies the input variable's documentation.
- validation - A block to define validation rules, usually in addition to type constraints.
- sensitive - Limits Terraform UI output when the variable is used in configuration.
- nullable - Specify if the variable can be null within the module.

##### Variables types

- string, number, bool, list(<TYPE>), set(<TYPE>), map(<TYPE>), object({<ATTR NAME> = <TYPE>, ... }), tuple([<TYPE>, ...])

##### Setting values

- You can create a .tfvars file;
- Use can use the `var` argument: `terraform apply -var="image_id=ami-abc123"`
- Files named exactly terraform.tfvars or terraform.tfvars.json.
- Any files with names ending in .auto.tfvars or .auto.tfvars.json.
- You can export a environment variable, like `export TF_VAR_image_id=ami-abc123`. Mandatory start with `TF_VAR_`



#### Outputs 

```
output "instance_ip_addr" {
  value = aws_instance.server.private_ip
}
```

* Procondition

```
output "api_base_url" {
  value = "https://${aws_instance.example.private_dns}:8433/"

  # The EC2 instance must have an encrypted root volume.
  precondition {
    condition     = data.aws_ebs_volume.example.encrypted
    error_message = "The server's root volume is not encrypted."
  }
}
```

* sensitive field;