{{- define "service-clusterip.spec"}}
  type: ClusterIP

  {{- /* Add all the ports from the values */}}
  {{- with .Values.ports }}
  ports:
    {{- range . }}
      {{- /* Identify the type of an item */}}
      {{- if eq (printf "%T" .) "string" }}
        {{- if eq . "http"}}
  - name: {{ . }}
    port: 80
    targetPort: 8080
        {{- else if eq . "https" }}
  - name: {{ . }}
    port: 443
    targetPort: 8081
        {{- end}}
      {{- else}}
        {{- /* Filter out pod-only ports */}}
        {{- if .type }}
          {{- if ne .type "pod" | default false }}
  - name: {{ .name }}
    port: {{ .containerPort }}
    targetPort: {{ .containerPort }}
          {{- end -}}
        {{- end }}
      {{- end}}
    {{- end }}
  {{- end }}
{{- end}}
