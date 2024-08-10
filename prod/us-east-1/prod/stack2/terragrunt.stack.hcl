locals {
  version = "v0.0.1"
  environment = "dev"

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment
}

variables {
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
}

unit "db" {
  terraform {
    source = "git::git@github.com:gruntwork-io/terragrunt-infrastructure-modules-example.git//modules/mysql?ref=v0.8.0"
  }

  inputs = {
    # TODO: To avoid storing your DB password in the code, set it as the environment variable TF_VAR_master_password

    # From envcommon
    name              = "mysql_${local.env}"
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
    source = "git::git@github.com:gruntwork-io/terragrunt-infrastructure-modules-example.git//modules/api?ref=v0.6.2"
  }

  path   = "api" # default would be github.com/gruntwork-io/terragrunt-stacks/stacks/mock/api
}