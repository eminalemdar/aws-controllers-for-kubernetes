# DynamoDB Service Controller Examples

In this folder, you can find general examples for creating DynamoDB Resources from your
Kubernetes cluster with ACK (AWS Controllers for Kubernetes).

Basic DynamoDB Table creation:

```yaml
apiVersion: dynamodb.services.k8s.aws/v1alpha1
kind: Table
metadata:
  name: $TABLE_NAME
spec:
  tableName: $TABLE_NAME
  attributeDefinitions:
    - attributeName: $ATTRIBUTE_NAME
      attributeType: S
  keySchema:
    - attributeName: $ATTRIBUTE_NAME
      keyType: HASH
  localSecondaryIndexes:
    - indexName: LastPostIndex
      keySchema:
        - attributeName: $ATTRIBUTE_NAME
          keyType: HASH
      projection:
        projectionType: KEYS_ONLY
  provisionedThroughput:
    readCapacityUnits: 5
    writeCapacityUnits: 5
  tags:
    - key: $DYNAMODB_TABLE_TAG_KEY
      value: $DYNAMODB_TABLE_TAG_VALUE
```

## Create the DynamoDB Resource

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the DynamoDB Resource

```bash
kubectl delete table <table_name> #Change the table name accordingly and also change the resource name accordingly
```
