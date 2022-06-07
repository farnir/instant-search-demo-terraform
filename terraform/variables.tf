variable "github_token" {
  type        = string
  description = "Github token to watch repository."
}

variable "branch" {
  type        = string
  default     = "master"
  description = "Branch to monitor by Flux."
}

variable "github_image" {
  type        = string
  default     = "ghcr.io/farnir/instant-search-demo:v1.0.2-dev"
  description = "Image name that will be used for pod creation."
}

variable "target_path" {
  type        = "string"
  default     = "minikube"
  description = "Name of the cluster where flux will be active."
}

variable "algolia_namespace" {
  type        = "string"
  default     = "algolia-dev"
  description = "Name of the namespace where the pods will be created."
}

variable "app_name" {
  type        = "string"
  default     = "instant-search"
  description = "Name of the application."
}

variable "app_port" {
  type        = "integer"
  default     = 3000
  description = "Port listen by the application."
}