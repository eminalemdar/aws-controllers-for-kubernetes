# CloudTrail Service Controller Examples

In this folder, you can find general examples for creating CloudTrail Resources from your
Kubernetes cluster with ACK (AWS Controllers for Kubernetes).

Basic CloudTrail creation:

```yaml
apiVersion: cloudtrail.services.k8s.aws/v1alpha1
kind: Trail
metadata:
  name: $TRAIL_NAME
spec:
  name: $TRAIL_NAME
  s3BucketName: $BUCKET_NAME
  tags:
    - key: $TRAIL_TAG_KEY
      value: $TRAIL_TAG_VALUE
```

## Create the CloudTrail Resource

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the CloudTrail Resource

```bash
kubectl delete trail <trail_name> #Change the Trail name accordingly and also change the resource name accordingly
```
