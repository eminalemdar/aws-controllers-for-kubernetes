# EC2 Service Controller Examples

In this folder, you can find general examples for creating EC2 Resources from your
Kubernetes cluster with ACK (AWS Controllers for Kubernetes).

Basic VPC creation:

```yaml
apiVersion: ec2.services.k8s.aws/v1alpha1
kind: VPC
metadata:
  name: $VPC_NAME #Change the VPC Name
spec:
  cidrBlock: $CIDR_BLOCK #Change the CIDR Block
```

## Create the EC2 Resource

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the EC2 Resource

```bash
kubectl delete vpc <vpc_name> #Change the VPC name accordingly and also change the resource name accordingly
```
