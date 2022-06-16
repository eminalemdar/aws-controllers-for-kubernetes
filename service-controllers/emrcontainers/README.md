# EMR Containers Service Controller Examples

In this folder, you can find general examples for creating EMR Container Resources from your
Kubernetes cluster with ACK (AWS Controllers for Kubernetes).

Basic EMR Container Virtual Cluster creation:

```yaml
apiVersion: emrcontainers.services.k8s.aws/v1alpha1
kind: VirtualCluster
metadata:
  name: $VIRTUALCLUSTER_NAME
spec:
  name: $VIRTUALCLUSTER_NAME
  containerProvider:
    id: $EKS_CLUSTER_NAME
    type_: EKS
    info:
      eksInfo:
        namespace: $KUBERNETES_NAMESPACE 
```

## Create the EMR Container Virtual Cluster

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the EMR Container Virtual Cluster

```bash
kubectl delete virtualcluster <virtualcluster_name> #Change the Virtual Cluster name accordingly
```
