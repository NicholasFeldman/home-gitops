local probes = [
  { name: 'authentik', urls: ['https://authentik.feldman.tech'] },
  { name: 'mealie', urls: ['https://mealie.feldman.tech'] },
  { name: 'home-assistant', urls: ['https://home-assistant.feldman.tech'] },

  { name: 'grafana', urls: ['https://grafana.feldman.in'] },
];

[
  {
    apiVersion: 'monitoring.coreos.com/v1',
    kind: 'Probe',
    metadata: {
      name: probe.name,
    },
    spec: {
      jobName: probe.name,
      interval: '15s',
      module: 'http_2xx',
      prober: {
        url: 'kube-prometheus-blackbox-exporter.database.svc.cluster.local:19115',
      },
      targets: {
        staticConfig: {
          static: probe.urls,
        },
      },
    },
  } for probe in probes
]
