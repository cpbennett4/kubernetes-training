{{/* Sandbox: The sidecar */}}
{{- define "sandbox.sidecar" -}}
- name: sandbox-sidecar
  image: {{ .Values.sandbox.image | default "docker.otenv.com/ot-sandbox:1.0.3" }}
  ports:
    - containerPort: 1234
      name: sandbox
      protocol: TCP
  env:
  - name: SANDBOX_ROOT
    value: "/mnt/ot/sandbox"
  - name: SANDBOX_PORT
    value: "1234"
  resources:
    requests:
      memory: "16Mi"
      cpu: 1m
    limits:
      memory: "32Mi"
      cpu: 2m
{{- end -}}
