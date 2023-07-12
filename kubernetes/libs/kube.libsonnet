{
  Resource(apiVersion, kind, name):: {
    local this = self,
    apiVersion: apiVersion,
    kind: kind,
    metadata: {
      name: name,
      annotations: {
        "app.kubernetes.io/managed-by": "jsonnet",
      },
      labels: {},
    },
  },

  Namespace(name): $.Resource('v1', 'Namespace', name) {
  },

  PersistentVolumeClaim(name, storage='1Gi'): $.Resource('v1', 'PersistentVolumeClaim', name) {
    spec: {
      accessModes: [
        'ReadWriteOnce'
      ],
      resources: {
        requests: {
          storage: storage
        }
      }
    },
  },

  Service(name): $.Resource('v1', 'Service', name) {
    spec: {
      ports: [
        
      ]
    }
  }
}
