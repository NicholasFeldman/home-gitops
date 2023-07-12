local istio = import 'istio.libsonnet';

[
  istio.VirtualService('keycloak', 'istio-system/feldman-tech', 'auth.feldman.tech', 80) {
  }
]