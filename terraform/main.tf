terraform {
  required_providers {
    kubernetes = {
      source = "hashiscorp/kubernetes"
      version = ">= 2.0.0"
    }
    # flux = {
    #   source = "fluxcd/flux"
    #   version = ">= 0.0.13"
    # }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}