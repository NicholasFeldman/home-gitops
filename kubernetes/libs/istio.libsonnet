local kube = import 'kube.libsonnet';

{
  VirtualService(name, gateway, host, port): kube.Resource('networking.istio.io/v1beta1', 'VirtualService', name) {
    spec: {
        gateways: [
            'istio-system/feldman-in',
        ],
        hosts: [
            host
        ],
        http: [{
            match: [{
               uri:
                 prefix: '/'
            }],
            route: [{
                destination:
                  host: name
                  port:
                    number: port
            }]
        }]
    }
  },
}