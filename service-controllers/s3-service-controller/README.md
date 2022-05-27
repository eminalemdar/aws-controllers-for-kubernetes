# S3 Service Controller Examples

In this folder, you can find general examples for creating S3 Resources from your
Kubernetes cluster with ACK (AWS Controllers for Kubernetes).

Basic S3 Bucket creation:

```yaml
apiVersion: s3.services.k8s.aws/v1alpha1
kind: Bucket
metadata:
  name: $BUCKET_NAME
spec:
  name: $BUCKET_NAME
```

## Create the S3 Bucket

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the S3 Bucket

```bash
kubectl delete bucket <bucket_name> #Change the bucket name accordingly
```
