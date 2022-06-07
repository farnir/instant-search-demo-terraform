resource "kubernetes_namespace" "argocd_namespace" {
  metadata {
    name = "argocd"
  }
}

data "kubectl_file_documents" "argocd_install" {
    content = file("../manifests/argocd/install.yml")
}

resource "kubectl_manifest" "argocd" {
  depends_on = [
    kubernetes_namespace.argocd_namespace
  ]
  count     = length(data.kubectl_file_documents.argocd_install.documents)
  yaml_body = element(data.kubectl_file_documents.argocd_install.documents, count.index)
  override_namespace = "argocd"
}

data "kubectl_file_documents" "argocd_install_image_update" {
    content = file("../manifests/argocd/install_image_update.yml")
}

resource "kubectl_manifest" "argocd_image_update" {
  depends_on = [
    kubernetes_namespace.argocd_namespace
  ]
  count     = length(data.kubectl_file_documents.argocd_install_image_update.documents)
  yaml_body = element(data.kubectl_file_documents.argocd_install_image_update.documents, count.index)
  override_namespace = "argocd"
}

data "kubectl_file_documents" "instant-search-app" {
    content = file("../manifests/argocd/instant_search_deploy.yml")
}

resource "kubectl_manifest" "instant-search-app" {
    depends_on = [
      kubectl_manifest.argocd,
    ]
    count     = length(data.kubectl_file_documents.instant-search-app.documents)
    yaml_body = element(data.kubectl_file_documents.instant-search-app.documents, count.index)
    override_namespace = "argocd"
}