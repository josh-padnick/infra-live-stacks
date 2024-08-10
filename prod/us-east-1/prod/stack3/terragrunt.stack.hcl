locals {
  version = "v0.0.1"
  environment = "dev"

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment
}

stack {
  source = "/prod/stacks/app1"

  inputs = {
    db_module_version = "v0.63.0"
    api_module_version = "v0.32.0"
    db_storage_space = 100
    env_name = "${locals.environment}"
  }
}