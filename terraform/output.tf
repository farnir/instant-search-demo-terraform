output "node_port_search_apps" {
  value = kubernetes_service.search_app_service.spec.0.port.0.node_port
  description = "Port number corresponding to the Search App."
}

output "cluster_ip_search_apps" {
  value = kubernetes_service.search_app_service.spec.0.cluster_ip
  description = "IP corresponding to the Search App service assigned by k8s."
}