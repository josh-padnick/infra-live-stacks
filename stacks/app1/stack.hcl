variable "db_module_version" {
  description = "The version of the db module"
  type        = string
}

variable "api_module_version" {
  description = "The version of the api module"
  type        = string
}

variable "db_storage_space" {
  description = "The amount of database storage to allocate, in GB"
  type        = number
}

variable "env_name" {
  description = "The name of the environment"
  type = string
}

locals {
  stack_name = "MyApp"
}

unit "db" {
  terraform {
    source = "git::git@github.com:gruntwork-io/terragrunt-infrastructure-modules-example.git//modules/mysql?ref=${var.db_module_version}"
  }

  inputs = {
    # TODO: To avoid storing your DB password in the code, set it as the environment variable TF_VAR_master_password

    # From envcommon
    name              = "mysql_${local.stack_name}"
    instance_class    = "db.t2.micro"
    allocated_storage = 20
    storage_type      = "standard"
    master_username   = "admin"

    # Per stack
    instance_class    = "db.t2.medium"
    allocated_storage = 100
  }
}

unit "api" {
  terraform {
    source = "git::git@github.com:gruntwork-io/terragrunt-infrastructure-modules-example.git//modules/api?ref=${var.api_module_version}"
  }

  inputs = {
    db_url = "${unit.db.outputs.db_url}"
    docker_image_tag = "v5"
  }
}