# KMS Service Controller Examples

In this folder, you can find general examples for creating KMS Resources from your
Kubernetes cluster with ACK (AWS Controllers for Kubernetes).

Basic KMS Key creation:

```yaml
apiVersion: kms.services.k8s.aws/v1alpha1
kind: Key
metadata:
  name: $KEY_NAME
spec:
  description: "This is an example Key created with ACK Examples"
```

## Create the KMS Key

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the KMS Key

```bash
kubectl delete key <key_name> #Change the key name accordingly
```
