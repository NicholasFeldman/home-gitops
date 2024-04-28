local k = import "github.com/jsonnet-libs/k8s-libsonnet/1.29/main.libsonnet"

[
  k.core.v1.namespace.new('monitoring'),
]
