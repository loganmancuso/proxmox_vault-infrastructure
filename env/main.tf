##############################################################################
#
# Author: Logan Mancuso
# Created: 07.30.2023
#
##############################################################################

#######################################
# Provider
#######################################

terraform {
  required_version = ">= 1.6.0"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.23.0"
    }
  }
  backend "http" {
    address  = "https://gitlab.com/api/v4/projects/52104036/terraform/state/vault-infrastructure"
    username = "loganmancuso"
  }
}

provider "vault" {}