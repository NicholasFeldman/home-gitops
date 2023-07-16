local kube = import 'kube-libsonnet/kube.libsonnet';
local istio = import 'istio.libsonnet';

[
  kube.Namespace("auth") {},

  istio.VirtualService('keycloak', 'istio-system/feldman-tech', 'auth.feldman.tech') {
    http_routes: [
      istio.HttpRoute('keycloak', 80),
    ],
  },

  istio.VirtualService('openldap', 'istio-system/feldman-in', 'ldap.feldman.in') {
    tcp_routes: [
      istio.TcpRoute('openldap.auth.svc.cluster.local', 389, 1389),
    ],
  },
]
