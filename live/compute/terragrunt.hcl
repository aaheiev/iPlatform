include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

include "encryption" {
  path = find_in_parent_folders("encryption.hcl")
}

dependency "network" {
  config_path = "../network"
}

inputs = {
  vpc_name             = dependency.network.outputs.vpc_name
  cloudrun_subnet_name = dependency.network.outputs.cloudrun_subnet_name
}

terraform {
  source = "../../modules/compute"
  before_hook "set_workspace" {
    commands = ["plan", "state", "apply", "destroy", "output"]
    execute  = ["tofu", "workspace", "select", "-or-create=true", get_env("TG_WORKSPACE", "default")]
  }
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=${get_repo_root()}/conf/${get_env("TG_WORKSPACE","default")}/common.tfvars",
      "-var-file=${get_repo_root()}/conf/${get_env("TG_WORKSPACE","default")}/compute.tfvars"
    ]
  }
}