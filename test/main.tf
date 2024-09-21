variable "apps" {
  type = map(any)
  default = {
    "foo" = {
      "region" = "us-east-1",
    },
    "bar" = {
      "region" = "eu-west-1",
    },
    "baz" = {
      "region" = "ap-south-1",
    },
  }
}

variable "user" {
    type = map(object({
        name     = string
        is_admin = bool
    }))
    default = {
        1 = {
            name = "Felipe",
            is_admin = true
        },
        2 = {
            name = "Pele",
            is_admin = false
        }
    }
}

