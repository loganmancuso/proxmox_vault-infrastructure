##############################################################################
#
# Author: Logan Mancuso
# Created: 07.30.2023
#
##############################################################################

data "terraform_remote_state" "datacenter_infrastructure" {
  backend = "http"
  config = {
    address  = "https://gitlab.com/api/v4/projects/48634510/terraform/state/bytevault"
    username = "loganmancuso"
  }
}

locals {
  # datacenter_infrastructure
  node_name     = data.terraform_remote_state.datacenter_infrastructure.outputs.node_name
  node_ip       = data.terraform_remote_state.datacenter_infrastructure.outputs.node_ip
  cert_intranet = data.terraform_remote_state.datacenter_infrastructure.outputs.cert_intranet
}
