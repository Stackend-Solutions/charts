{{/*
Expand the name of the chart.
*/}}
{{- define "django-api-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "django-api-chart.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "django-api-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}

{{- define "django-api-chart.labels" -}}
helm.sh/chart: {{ include "django-api-chart.chart" . }}
{{ include "django-api-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "django-api-chart.celeryWorkerLabels" -}}
helm.sh/chart: {{ include "django-api-chart.chart" . }}
{{ include "django-api-chart.celeryWorkerSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "django-api-chart.celery_beat_labels" -}}
helm.sh/chart: {{ include "django-api-chart.chart" . }}
{{ include "django-api-chart.celeryBeatSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "django-api-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "django-api-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "django-api-chart.celeryWorkerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "django-api-chart.name" . }}
app.kubernetes.io/instance: {{ .Values.projectName }}-celery-worker-{{ .Values.environment }}
{{- end }}

{{- define "django-api-chart.celeryBeatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "django-api-chart.name" . }}
app.kubernetes.io/instance: {{ .Values.projectName }}-celery-beat-{{ .Values.environment }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "django-api-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "django-api-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
