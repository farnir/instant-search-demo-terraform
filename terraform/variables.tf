variable "argocd_namespace" {
  type    = string
  default = "argocd"
  description = "Default namespace for ArgoCD components."
}

variable "app_namespace" {
  type    = string
  default = "algolia-dev"
  description = "Custom namespace for Application components."
}

variable "app_name" {
  type    = string
  default = "instant-search"
  description = "Application name for ArgoCD application manifest."
}

variable "default_image" {
  type    = string
  default = "ghcr.io/farnir/instant-search-demo:~v1.0.2-dev"
  description = "Application default image for ArgoCD Image Update manifest."
}

variable "manifest_repository" {
  type    = string
  default = "https://github.com/farnir/instant-search-demo-terraform.git"
  description = "Repository that contains all the applications manifest for ArgoCD."
}

variable "manifest_path" {
  type    = string
  default = "manifests/app/"
  description = "Manifest path inside the manifest_repository for ArgoCD."
}