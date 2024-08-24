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

##### Variable parameters: 

- default - A default value which then makes the variable optional.
- type - This argument specifies what value types are accepted for the variable.
- description - This specifies the input variable's documentation.
- validation - A block to define validation rules, usually in addition to type constraints.
- sensitive - Limits Terraform UI output when the variable is used in configuration.
- nullable - Specify if the variable can be null within the module.

###### Variables types

- string, number, bool, list(<TYPE>), set(<TYPE>), map(<TYPE>), object({<ATTR NAME> = <TYPE>, ... }), tuple([<TYPE>, ...])