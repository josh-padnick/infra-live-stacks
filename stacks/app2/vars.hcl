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