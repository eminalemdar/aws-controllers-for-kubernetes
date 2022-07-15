# MemoryDB Service Controller Examples

In this folder, you can find general examples for creating MemoryDB Resources from your
Kubernetes cluster with ACK (AWS Controllers for Kubernetes).

Basic MemoryDB Cluster creation:

```yaml
apiVersion: memorydb.services.k8s.aws/v1alpha1
kind: Cluster
metadata:
  name: $CLUSTER_NAME
spec:
  name: $CLUSTER_NAME
  aclName: $ACL_NAME
  nodeType: $NODE_TYPE
  tags:
    - key: $CLUSTER_TAG_KEY
      value: $CLUSTER_TAG_VALUE
```

## Create the MemoryDB Resource

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the MemoryDB Resource

```bash
kubectl delete cluster <cluster_name> #Change the Topic name accordingly and also change the resource name accordingly
```
