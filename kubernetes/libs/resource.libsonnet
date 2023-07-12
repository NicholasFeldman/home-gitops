{
  Resource(apiVersion, kind, name):: {
    local this = self,
    apiVersion: apiVersion,
    kind: kind,
    metadata: {
      name: name,
      labels: {
        name: std.join('-', std.split(this.metadata.name, ':'))
      },
      annotations: {},
    },
  },

  Namespace(name): $.Resource('v1', 'Namespace', name) {
  },
}
