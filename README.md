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
* terraform get

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


#### State

* You can create a remote state 

´´´
  terraform {
  required_version = ">= v1.9.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.63.0"
    }
  }

  backend "s3" {
    bucket = "fcfunck-remote-state"
    key    = "aws-vm/terraform.tfstate"
    region = "us-east-1"
  }

}
´´´

* ´terraform show -json´ to give you a readable output of your state;
* terraform state: Subcommands:
    list                List resources in the state
    mv                  Move an item in the state, ex: terraform state mv resource.old_name resource.new_name
    pull                Pull current state and output to stdout
    push                Update remote state from a local state file
    replace-provider    Replace provider in the state
    rm                  Remove instances from the state
    show                Show a resource in the state

* terraform import: Import existent resource to your state
Ex: ´terraform import aws_instance.foo <id-resource>´

* terraform reflesh: eads the current settings from all managed remote objects and updates the Terraform state to match.
Ex: terraform refresh [options]






### Terraform meta arguments

##### for_each

```
  resource "azurerm_resource_group" "rg" {
    for_each = tomap({
      a_group       = "eastus"
      another_group = "westus2"
    })
    name     = each.key
    location = each.value
  }

  resource "aws_iam_user" "the-accounts" {
    for_each = toset(["Todd", "James", "Alice", "Dottie"])
    name     = each.key
  }

```

##### count

```
  resource "aws_instance" "server" {
    count = 4 # create four similar EC2 instances

    ami           = "ami-a1b2c3d4"
    instance_type = "t2.micro"

    tags = {
      Name = "Server ${count.index}"
    }
  }

```

##### lifecycle

* The Resource Behavior page describes the general lifecycle for resources. Some details of that behavior can be customized using the special nested lifecycle block within a resource block body:

```
  resource "azurerm_resource_group" "example" {
    # ...

    lifecycle {
      create_before_destroy = true
    }
  }
```

* create_before_destroy (bool) - By default, when Terraform must change a resource argument that cannot be updated in-place due to remote API limitations, Terraform will instead destroy the existing object and then create a new replacement object with the new configured arguments.The create_before_destroy meta-argument changes this behavior so that the new replacement object is created first, and the prior object is destroyed after the replacement is created.

* prevent_destroy (bool) - This meta-argument, when set to true, will cause Terraform to reject with an error any plan that would destroy the infrastructure object associated with the resource, as long as the argument remains present in the configuration.

* ignore_changes (list of attribute names) - By default, Terraform detects any difference in the current settings of a real infrastructure object and plans to update the remote object to match configuration.

```
  resource "aws_instance" "example" {
    # ...

    lifecycle {
      ignore_changes = [
        # Ignore changes to tags, e.g. because a management agent
        # updates these based on some ruleset managed elsewhere.
        tags,
      ]
    }
  }
```

* replace_triggered_by (list of resource or attribute references) - Added in Terraform 1.2. Replaces the resource when any of the referenced items change. Supply a list of expressions referencing managed resources, instances, or instance attributes. When used in a resource that uses count or for_each, you can use count.index or each.key in the expression to reference specific instances of other resources that are configured with the same count or collection.

```
    resource "aws_appautoscaling_target" "ecs_target" {
    # ...
      lifecycle {
        replace_triggered_by = [
          # Replace `aws_appautoscaling_target` each time this instance of
          # the `aws_ecs_service` is replaced.
          aws_ecs_service.svc.id
        ]
      }
    }

```





### Functions And Expressions

* condition expression ´var.a != "" ? var.a : "default-a"´

##### for expressions

* You can use for to return a list: ´[for s in var.list : upper(s)]´ or ´[for k, v in var.map : length(k) + length(v)]´

* You can use for to return a map: ´{for s in var.list : s => upper(s)}´

* You can apply filters ´[for s in var.list : upper(s) if s != ""]´

´´´
variable "users" {
  type = map(object({
    is_admin = bool
  }))
}

locals {
  admin_users = {
    for name, user in var.users : name => user
    if user.is_admin
  }
  regular_users = {
    for name, user in var.users : name => user
    if !user.is_admin
  }
}

´´´