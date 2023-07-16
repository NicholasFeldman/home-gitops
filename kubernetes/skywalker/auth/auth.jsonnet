local kube = import 'kube.libsonnet';

[
  kube.Namespace("auth") {
  },

  istio.VirtualService('keycloak', 'istio-system/feldman-tech', 'auth.feldman.tech') {
    spec+: {
      http: [
        istio.HttpRoute('keycloak', 80)
      ]
    }
  },

  istio.VirtualService('openldap', 'istio-system/feldman-in', 'auth.feldman.tech', 80) {
    spec+: {
      tcp: [
        istio.TcpRoute('openldap.auth.svc.cluster.local', 389, 1389)
      ]
    }
  },
]
