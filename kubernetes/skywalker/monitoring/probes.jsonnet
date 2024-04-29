local probes = [
  // Application
  { name: 'authentik', urls: ['https://authentik.feldman.tech'] },
  { name: 'mealie', urls: ['https://mealie.feldman.tech'] },
  { name: 'home-assistant', urls: ['https://home-assistant.feldman.tech'] },

  { name: 'grafana', urls: ['https://grafana.feldman.in'] },
  { name: 'freshrss', urls: ['https://freshrss.feldman.in'] },
  { name: 'homepage', urls: ['https://homepage.feldman.in'] },
  { name: 'node-red', urls: ['https://node-red.feldman.in'] },
  { name: 'spoolman', urls: ['https://spoolman.feldman.in'] },
  { name: 'snipe-it', urls: ['https://snipeit.feldman.in'] },

  // Cluster
  { name: 'argocd', urls: ['https://argocd.feldman.in'] },
  { name: 'longhorn', urls: ['https://longhorn.feldman.in'] },

  // Database
  { name: 'influxdb', urls: ['https://influxdb.feldman.in'] },

  // Media
  { name: 'jellyfin', urls: ['https://jellyfin.feldman.in'] },

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
