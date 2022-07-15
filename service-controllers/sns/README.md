# SNS Service Controller Examples

In this folder, you can find general examples for creating SNS Resources from your
Kubernetes cluster with ACK (AWS Controllers for Kubernetes).

Basic SNS Topic creation:

```yaml
apiVersion: sns.services.k8s.aws/v1alpha1
kind: Topic
metadata:
  name: $TOPIC_NAME
spec:
  name: $TOPIC_NAME
  displayName: $DISPLAY_NAME
  tags:
    - key: $TOPIC_TAG_KEY
      value: $TOPIC_TAG_VALUE
```

## Create the SNS Resource

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the SNS Resource

```bash
kubectl delete topic <topic_name> #Change the Topic name accordingly and also change the resource name accordingly
```
