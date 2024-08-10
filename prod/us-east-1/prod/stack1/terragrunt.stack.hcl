// This is the exact example from https://github.com/gruntwork-io/terragrunt/issues/3313.
//
// My concern here is that it represents a one-time combination of units, but not a *definition* of a common set of reusable units
// Indeed, the I see the key value-add of a stack as allowing you to define a *reusable combination of units* that you can uniquely
// configure on each instance.
//
// I'll try to explore that in stack2

locals {
  version = "v0.0.1"
  environment = "dev"
}

unit "service" {
  source = "github.com/gruntwork-io/terragrunt-stacks//stacks/mock/service?ref=${local.version}"
  path   = "service" # default would be github.com/gruntwork-io/terragrunt-stacks/stacks/mock/service
}

unit "db" {
  source = "github.com/gruntwork-io/terragrunt-stacks//stacks/mock/db?ref=${local.version}"
  path   = "db" # default would be github.com/gruntwork-io/terragrunt-stacks/stacks/mock/db
}

unit "api" {
  source = "github.com/gruntwork-io/terragrunt-stacks//stacks/mock/api?ref=${local.version}"
  path   = "api" # default would be github.com/gruntwork-io/terragrunt-stacks/stacks/mock/api
}