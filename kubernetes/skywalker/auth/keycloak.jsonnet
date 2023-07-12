local istio = import 'istio.libsonnet';

[
  istio.VirtualService('keycloak', 'istio-system/feldman-tech', 80) {
  }
]