resource "kubernetes_namespace" "argocd_namespace" {
  metadata {
    name = var.argocd_namespace
  }
}

data "kubectl_file_documents" "argocd_install" {
    content = file("../manifests/argocd/install.yml")
}

resource "kubectl_manifest" "argocd" {
  depends_on = [
    kubernetes_namespace.argocd_namespace
  ]
  for_each  = data.kubectl_file_documents.argocd_install.manifests
  yaml_body = each.value
  override_namespace = var.argocd_namespace
}

data "kubectl_file_documents" "argocd_install_image_update" {
    content = file("../manifests/argocd/install_image_update.yml")
}

resource "kubectl_manifest" "argocd_image_update" {
  depends_on = [
    kubernetes_namespace.argocd_namespace
  ]
  for_each  = data.kubectl_file_documents.argocd_install_image_update.manifests
  yaml_body = each.value
  override_namespace = var.argocd_namespace
}

data "template_file" "instant-search-app" {
  template = file("../manifests/argocd/application_template.yml")
  vars = {
    MANIFEST_REPOSITORY       = var.manifest_repository
    MANIFEST_PATH             = var.manifest_path
    DEFAULT_IMAGE             = var.default_image
    APPLICATION_NAME          = var.app_name
    ARGOCD_NAMESPACE          = var.argocd_namespace
    UPDATE_STRATEGY           = "latest"
    TARGET_REVISION           = "HEAD"
  }
}

resource "kubectl_manifest" "instant-search-app" {
    depends_on = [
      kubectl_manifest.argocd,
    ]
    yaml_body = data.template_file.instant-search-app.rendered
    override_namespace = var.argocd_namespace
}