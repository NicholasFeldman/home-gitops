[
  {
    apiVersion: 'monitoring.coreos.com/v1',
    kind: 'Probe',
    metadata: {
      name: 'mealie',
    },
    spec: {
      jobName: 'mealie',
      interval: '15s',
      module: 'http_2xx',
      prober: {
        url: 'kube-prometheus-blackbox-exporter.database.svc.cluster.local:19115',
      },
      targets: {
        staticConfig: {
          static: [
            'https://mealie.feldman.tech',
          ],
        },
      },
    },
  },
]