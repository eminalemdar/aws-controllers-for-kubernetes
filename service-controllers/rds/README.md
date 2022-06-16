# RDS Service Controller Examples

In this folder, you can find general examples for creating RDS Resources from your
Kubernetes cluster with ACK (AWS Controllers for Kubernetes).

Basic RDS DB Instance creation:

```yaml
apiVersion: rds.services.k8s.aws/v1alpha1
kind: DBInstance
metadata:
  name: $DB_INSTANCE_ID 
spec:
  allocatedStorage: 5
  dbInstanceClass: db.t3.micro 
  dbInstanceIdentifier: $DB_INSTANCE_ID 
  dbSubnetGroupName: $DB_SUBNET_GROUP_NAME 
  engine: postgres 
  engineVersion: "14.1" 
  masterUsername: root 
  masterUserPassword:
    namespace: $MASTER_USER_PASS_SECRET_NAMESPACE 
    name: $MASTER_USER_PASS_SECRET_NAME 
    key: $MASTER_USER_PASS_SECRET_KEY 
  multiAZ: False 
```

## Create the RDS Resource

```bash
kubectl apply -f <file_name> #Change the file name accordingly
```

## Delete the RDS Resource

```bash
kubectl delete dbinstance <dbinstance_name> #Change the db instance name accordingly and also change the resource name accordingly
```
