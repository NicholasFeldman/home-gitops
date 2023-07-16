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
}
