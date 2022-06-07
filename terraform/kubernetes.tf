resource "kubernetes_namespace" "algolia_namespace" {
  metadata {
    name = var.algolia_namespace
  }
}

resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name      = "${var.app_name}-deployment"
    namespace = kubernetes_namespace.algolia_namespace.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.app_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }
      spec {
        container {
          image = var.github_image
          name  = "${var.app_name}-container"
          port {
            container_port = var.app_port
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "search_app_service" {
  metadata {
    name      = "${var.app_name}-service"
    namespace = kubernetes_namespace.algolia_namespace.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.app_deployment.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      port        = var.app_port
      target_port = var.app_port
    }
  }
}