local kube = import 'kube.libsonnet';

{
  VirtualService(name, gateway, host): kube.Resource('networking.istio.io/v1beta1', 'VirtualService', name) {
    local virtualService = self,

    http_routes:: [],
    tcp_routes:: [],
    
    spec: {
        gateways: [
            gateway,
        ],
        hosts: [
            host,
        ],
        http: self.http_routes,
        tcp: self.tcp_routes,
    },
  },

  HttpRoute(host, port): {
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
  },

  TcpRoute(host, fromPort, toPort): {
    match: [{
        port: fromPort,
    }],
    route: [{
        destination: {
            host: host,
            port: {
                number: toPort,
            },
        },
    }],
  },
}
