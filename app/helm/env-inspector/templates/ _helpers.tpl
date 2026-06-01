{{- define "env-inspector.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "env-inspector.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "env-inspector.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "env-inspector.labels" -}}
app.kubernetes.io/name: {{ include "env-inspector.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}