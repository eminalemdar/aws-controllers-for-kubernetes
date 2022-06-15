# IAM Service Controller Examples

In this folder, you can find general examples for creating IAM Resources from your
Kubernetes cluster with ACK (AWS Controllers for Kubernetes).

Basic IAM Role creation:

```yaml
apiVersion: iam.services.k8s.aws/v1alpha1
kind: Role
metadata:
  name: $ROLE_NAME 
spec:
  name: $ROLE_NAME 
  description: $ROLE_DESCRIPTION 
  assumeRolePolicyDocument: >
    {
      "Version":"2012-10-17",
      "Statement": [{
        "Effect":"Allow",
        "Principal": {
          "Service": [
            "ec2.amazonaws.com"
          ]
        },
        "Action": ["sts:AssumeRole"]
      }]
    }
  tags:
    - key: $IAM_ROLE_TAG_KEY 
      value: $IAM_ROLE_TAG_VALUE 
```

## Create the IAM Resource

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the IAM Resource

```bash
kubectl delete role <role_name> #Change the role name accordingly and also change the resource name accordingly
```
