# DynamoDB Service Controller Examples

In this folder, you can find general examples for creating DynamoDB Resources from your
Kubernetes cluster with ACK (AWS Controllers for Kubernetes).

Basic DynamoDB Table creation:

```yaml
apiVersion: dynamodb.services.k8s.aws/v1alpha1
kind: Table
metadata:
  name: $TABLE_NAME #Change the DynamoDB Table Name
spec:
  tableName: $TABLE_NAME #Change the DynamoDB Table Name
  attributeDefinitions:
    - attributeName: $ATTRIBUTE_NAME #Change the Attribute Name
      attributeType: S
  keySchema:
    - attributeName: $ATTRIBUTE_NAME #Change the Attribute Name
      keyType: HASH
  localSecondaryIndexes:
    - indexName: LastPostIndex
      keySchema:
        - attributeName: $ATTRIBUTE_NAME #Change the Attribute Name
          keyType: HASH
      projection:
        projectionType: KEYS_ONLY
  provisionedThroughput:
    readCapacityUnits: 5 #You can change the Capacity units accordingly
    writeCapacityUnits: 5 #You can change the Capacity units accordingly
  tags:
    - key: $DYNAMODB_TABLE_TAG_KEY #Change the tag key
      value: $DYNAMODB_TABLE_TAG_VALUE #Change the tag value
```

## Create the DynamoDB Resource

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the DynamoDB Resource

```bash
kubectl delete table <table_name> #Change the table name accordingly and also change the resource name accordingly
```
