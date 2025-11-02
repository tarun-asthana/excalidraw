{{- define "excalidraw.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "excalidraw.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "excalidraw.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "excalidraw.labels-all" -}}
helm.sh/chart: {{ include "excalidraw.chart" . }}
{{ include "excalidraw.selectorLabels-all" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "excalidraw.labels-main" -}}
{{ include "excalidraw.labels-all" . }}
app: excalidraw-main
{{- end }}

{{- define "excalidraw.labels-collab" -}}
{{ include "excalidraw.labels-all" . }}
app: excalidraw-collab
{{- end }}

{{- define "excalidraw.selectorLabels-all" -}}
app.kubernetes.io/name: {{ include "excalidraw.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "excalidraw.selectorLabels-main" -}}
{{ include "excalidraw.selectorLabels-all" . }}
app: excalidraw-main
{{- end }}

{{- define "excalidraw.selectorLabels-collab" -}}
{{ include "excalidraw.selectorLabels-all" . }}
app: excalidraw-collab
{{- end }}

{{- define "excalidraw.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "excalidraw.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

