# ECR Service Controller Examples

In this folder you can find general examples for creating ECR Resources from
your Kubernetes Cluster with ACK (AWS Controllers for Kubernetes).

Basic ECR creation:

```yaml
apiVersion: ecr.services.k8s.aws/v1alpha1
kind: Repository
metadata:
  name: $REPOSITORY_NAME #Change the Repository Name
spec:
  name: $REPOSITORY_NAME #Change the Repository Name
```

## Create the ECR Repository

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the ECR Repository

```bash
kubectl delete repository <bucket_name> #Change the repository name accordingly
```
