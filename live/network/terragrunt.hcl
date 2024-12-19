include "root" {
  path = find_in_parent_folders()
}

# dependency "base" {
#   config_path = "../base"
# }
#
# dependency "compute" {
#   config_path = "../compute"
# }
#
# dependency "shared_services" {
#   config_path = "../shared-services"
# }

inputs = {
  nat_ip_addresses_count = 2
#   akv_name          = dependency.shared_services.outputs.shared_services_key_vault
#   akv_rg            = dependency.shared_services.outputs.shared_services_rg
#   env_domain_name   = dependency.base.outputs.env_domain_name
#   env_domain_rg     = dependency.base.outputs.env_domain_rg
#   aks_name          = dependency.compute.outputs.aks_name
#   aks_rg            = dependency.compute.outputs.aks_rg
#   istio_gateway_pip = dependency.compute.outputs.istio_gateway_pip
}

terraform {
  source = "../../modules/network"
  before_hook "set_workspace" {
    commands = ["plan", "state", "apply", "destroy"]
    execute = ["terraform", "workspace", "select", get_env("TG_WORKSPACE", "default")]
  }
  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "destroy"
    ]
    arguments = [
      "-var-file=${get_repo_root()}/conf/${get_env("TG_WORKSPACE","default")}.tfvars"
    ]
  }
}
