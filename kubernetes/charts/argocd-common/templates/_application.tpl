{{- define "argocd-common.application" -}}
{{ range .Values.applications }}
---
apiVersion: argoproj.io/v1alpha1
kind: Application

metadata:
  {{/* If our source is git, assume we are installing a namespace root.
       If it's helm, assume we are installing a chart into one of those namespaces */}}
  name: {{$.Values.cluster }}-{{$.Chart.Name}}{{if .source.helm}}-{{.source.helm.releaseName}}{{end}}
  {{/* For now, we always want to install applications to the argocd namespace */}}
  namespace: argocd

spec:
  destination:
    namespace: {{$.Release.Namespace}}
    name: in-cluster {{/* TODO: Multi cluster support */}}
  project: {{ $.Values.cluster }}
  source: {{ .source | toYaml | nindent 4 }}
{{ end }}
{{- end -}}
