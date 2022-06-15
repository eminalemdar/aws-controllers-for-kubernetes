# EKS Service Controller Examples

In this folder you can find general examples for creating EKS Resources from
your Kubernetes Cluster with ACK (AWS Controllers for Kubernetes).

Basic EKS creation:

```yaml
apiVersion: eks.services.k8s.aws/v1alpha1
kind: Cluster
metadata:
  name: $CLUSTER_NAME
spec:
  name: $CLUSTER_NAME
  roleARN: $CLUSTER_ROLE
  resourcesVPCConfig:
    endpointPrivateAccess: true
    endpointPublicAccess: false
    subnetIDs:
      - "$PUBLIC_SUBNET_1" 
      - "$PUBLIC_SUBNET_2" 
  version: $KUBERNETES_VERSION 
```

## Create the EKS Repository

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the EKS Repository

```bash
kubectl delete cluster <cluster_name> #Change the cluster name accordingly
```
