local kube = import 'kube.libsonnet';

{
  VirtualService(name, gateway, host): kube.Resource('networking.istio.io/v1beta1', 'VirtualService', name) {
    spec: {
        gateways: [
            gateway,
        ],
        hosts: [
            host,
        ],
    },
  },

  HttpRoute(host, port) {
    match: [{
        uri: {
            prefix: '/',
        },
    }],
    route: [{
        destination: {
            host: host,
            port: {
                number: port,
            },
        },
    }],
  }

  TcpRoute(host, fromPort, toPort) {
    match: [{
        port: fromPort
    }],
    route: [{
        destination: {
            host: host,
            port: {
                number: toPort,
            },
        },
    }],
  }
}
