#!/bin/bash

: '
This script requires that you have the following values exported:
export K8S_INT_OTLP_USERNAME_BASE64=
export K8S_INT_OTLP_PASSSWORD_BASE64=
'

echo "
---
apiVersion: v1
kind: Namespace
metadata:
  name: collector

---
apiVersion: v1
kind: Secret
metadata:
  name: grafanacloud-otlphttp-secret
  namespace: collector
type: Opaque
data:
  username: $K8S_INT_OTLP_USERNAME_BASE64
  password: $K8S_INT_OTLP_PASSSWORD_BASE64
" | kubectl apply -f -
