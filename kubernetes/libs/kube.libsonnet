{
  Resource(apiVersion, kind, name):: {
    local this = self,
    apiVersion: apiVersion,
    kind: kind,
    metadata: {
      name: name,
      annotations: {},
      labels: {},
    },
  },

  Namespace(name): $.Resource('v1', 'Namespace', name) {
  },
}
