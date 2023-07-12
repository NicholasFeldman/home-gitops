local kube = import 'kube.libsonnet';

[
  kube.Namespace("auth"),
]
