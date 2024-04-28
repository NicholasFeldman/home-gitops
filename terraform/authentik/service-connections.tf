resource "authentik_service_connection_kubernetes" "local-kubernetes" {
    name = "Local Kubernetes Cluster"
    local = true
}
