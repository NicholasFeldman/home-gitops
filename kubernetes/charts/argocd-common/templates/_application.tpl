{{- define "argocd-common.application" -}}
{{ range .Values.applications }}
---
apiVersion: argoproj.io/v1alpha1
kind: Application

metadata:
  name: {{$.Values.cluster }}-{{ .name }}
  {{/* For now, we always want to install applications to the argocd namespace */}}
  namespace: argocd

spec:
  destination:
    namespace: {{ .destination.namespace }}
    name: in-cluster {{/* TODO: Multi cluster support */}}
  project: {{ $.Values.cluster }}
  source: {{ .source | toYaml | nindent 4 }}
{{ end }}
{{- end -}}
