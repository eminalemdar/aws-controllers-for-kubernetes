# EMR Containers Service Controller Examples

In this folder, you can find general examples for creating EMR Container Resources from your
Kubernetes cluster with ACK (AWS Controllers for Kubernetes).

Basic EMR Container Virtual Cluster creation:

```yaml
apiVersion: EMR Containers.services.k8s.aws/v1alpha1
kind: Key
metadata:
  name: $KEY_NAME #Change the EMR Containers Key Name
spec:
  description: "This is an example Key created with ACK Examples"
```

## Create the EMR Container Virtual Cluster

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the EMR Container Virtual Cluster

```bash
kubectl delete virtualcluster <virtualcluster_name> #Change the Virtual Cluster name accordingly
```
